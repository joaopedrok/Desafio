import Foundation

protocol RequestClient {
    func requestObject<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (APIResult<T>) -> Void)
}

public enum APIError: Error, Equatable {
    case parseError(errorMessage: String)
    case apiError(statusCode: Int, errorMessage: String)
    case networkError(errorMessage: String)

    var localizedDescription: String {
        switch self {
        case let .parseError(errorMessage):
            return errorMessage

        case let .apiError(_, errorMessage):
            return errorMessage

        case let .networkError(errorMessage):
            return errorMessage
        }
    }

    public static func == (lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
        case let (.apiError(_, messageOne), .apiError(_, messageTwo)):
            return messageOne == messageTwo

        case let (.networkError(messageOne), .networkError(messageTwo)):
            return messageOne == messageTwo

        case let (.parseError(messageOne), .parseError(messageTwo)):
            return messageOne == messageTwo

        default:
            return false
        }
    }
}

enum APIResult<T>: Equatable {
    case success(T)
    case failure(APIError)

    public static func == (lhs: APIResult, rhs: APIResult) -> Bool {
        switch (lhs, rhs) {
        case let (.failure(errorOne), .failure(errorTwo)):
            return errorOne == errorTwo
        case (.success, .success):
            return true

        default:
            return false
        }
    }
}

class APIClient: RequestClient {
    let requestManager: RequestManager

    init(_ requestManager: RequestManager = RequestManager()) {
        self.requestManager = requestManager
    }

    func tryMapObject<T: Decodable>(data: Data) -> APIResult<T> {
        do {
            let object = try JSONDecoder().decode(T.self, from: data)
            return APIResult.success(object)
        } catch {
            print(error)
            return APIResult.failure(APIError.parseError(errorMessage: "Fail to parse object"))
        }
    }

    func treatAPIResultForObject<T: Decodable>(endpoint _: Endpoint, response: DataResponse<Data>) -> APIResult<T> {
        switch response.result {
        case let .success(value):
            return tryMapObject(data: value)

        case let .failure(error):
            guard let statusCode = response.response?.statusCode else {
                return APIResult.failure(APIError.networkError(errorMessage: "Connection error. Try again later"))
            }

            return APIResult.failure(APIError.apiError(statusCode: statusCode, errorMessage: error.localizedDescription))
        }
    }

    func requestObject<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (APIResult<T>) -> Void) {
        let fullPath = endpoint.baseURL.appendingPathComponent(endpoint.path)
        let method = endpoint.method
        let parameters = endpoint.parameters
        let encoding = endpoint.parameterEncoding

        requestManager.request(method: method, url: fullPath, parameters: parameters, encoding: encoding) { responseData in
            let result: APIResult<T> = self.treatAPIResultForObject(endpoint: endpoint, response: responseData)
            completion(result)
        }
    }
}
