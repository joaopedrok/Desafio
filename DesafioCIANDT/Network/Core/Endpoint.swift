import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var method: HTTPMethod { get }
    var parameters: Parameters? { get set }
    var path: String { get }
    var parameterEncoding: ParameterEncoding { get }
}
