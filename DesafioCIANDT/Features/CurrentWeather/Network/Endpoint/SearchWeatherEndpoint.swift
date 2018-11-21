import Foundation

struct SearchWeatherEndpoint: Endpoint {
    var baseURL: URL {
        return URL(string: Settings.shared.apiURL)!
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters?

    var path: String {
        return "weather"
    }

    var parameterEncoding: ParameterEncoding {
        return URLEncoding()
    }
}
