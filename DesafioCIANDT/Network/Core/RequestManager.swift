import Foundation

typealias Parameters = [String: Any]
typealias RequestCompletion = (DataResponse<Data>) -> Void

enum Result<T>: Equatable {
    case success(T)
    case failure(Error)

    public static func == (lhs: Result, rhs: Result) -> Bool {
        switch (lhs, rhs) {
        case (.success, .success), (.failure, .failure):
            return true

        default:
            return false
        }
    }
}

enum HTTPMethod: CustomStringConvertible {
    case post, get

    var description: String {
        switch self {
        case .post:
            return "POST"
        case .get:
            return "GET"
        }
    }
}

enum RequestManagerError: Error {
    case unknown
    case invalidResponse
    case responseDataNil
    case unexpected

    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .invalidResponse:
            return "Fail to serialize response"
        case .responseDataNil:
            return "Data is nil in response"
        case .unexpected:
            return "Unexpected error at server"
        }
    }
}

class RequestManager {
    let session: URLSession

    init(session: URLSession = URLSession(configuration: URLSessionConfiguration.default)) {
        self.session = session
    }

    func request(method: HTTPMethod,
                 url: URL,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding,
                 completion: @escaping RequestCompletion) {
        var request = URLRequest(url: url)
        request.httpMethod = method.description

        request = encoding.encode(url: request, parameters: parameters)

        let task = session.dataTask(with: request) { [unowned self] data, urlResponse, error in
            let response = urlResponse as? HTTPURLResponse
            let result = self.serializeResponse(data: data,
                                                error: error,
                                                response: response)

            let dataResponse = DataResponse(result: result,
                                            response: response)

            DispatchQueue.main.async {
                completion(dataResponse)
            }
        }

        task.resume()
    }

    private func serializeResponse(data: Data?, error: Error?, response: HTTPURLResponse?) -> Result<Data> {
        guard let response = response else {
            return .failure(RequestManagerError.invalidResponse)
        }

        guard 200 ... 209 ~= response.statusCode else {
            return .failure(RequestManagerError.unexpected)
        }

        guard error == nil else {
            return .failure(error!)
        }

        guard let data = data else {
            return .failure(RequestManagerError.responseDataNil)
        }

        return .success(data)
    }
}
