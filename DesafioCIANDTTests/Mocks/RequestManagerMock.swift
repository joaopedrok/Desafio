@testable import DesafioCIANDT
import Foundation

class RequestManagerMock: RequestManager {
    var dataResponseResult: DataResponse<Data>?

    override func request(method _: HTTPMethod, url: URL, parameters: Parameters?, encoding: ParameterEncoding, completion: @escaping RequestCompletion) {
        if let dataResponse = dataResponseResult {
            completion(dataResponse)
        }
    }
}
