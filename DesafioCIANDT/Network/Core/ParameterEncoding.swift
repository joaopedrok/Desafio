import Foundation

protocol ParameterEncoding {
    func encode(url: URLRequest, parameters: Parameters?) -> URLRequest
}

extension ParameterEncoding {
    func createQueryParameter(parameters: Parameters, key: String) -> URLQueryItem {
        if let value = parameters[key] as? String {
            return URLQueryItem(name: key, value: value)
        }

        if let value = parameters[key] as? NSNumber {
            return URLQueryItem(name: key, value: value.stringValue)
        }

        return URLQueryItem(name: key, value: nil)
    }
}

class URLEncoding: ParameterEncoding {
    func encode(url: URLRequest, parameters: Parameters?) -> URLRequest {
        var urlRequest = url

        guard let parameters = parameters else { return urlRequest }
        guard let url = urlRequest.url else { return urlRequest }

        if var components = URLComponents(url: url, resolvingAgainstBaseURL: false) {
            let keys = Array(parameters.keys.sorted(by: <))

            let queryItems = keys.map { key -> URLQueryItem in
                return createQueryParameter(parameters: parameters, key: key)
            }

            components.queryItems = queryItems
            urlRequest.url = components.url
        }

        return urlRequest
    }
}
