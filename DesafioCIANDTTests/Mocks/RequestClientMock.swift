@testable import DesafioCIANDT
import Foundation

class RequestClientMock: RequestClient {
    var isRequestObjectCalled = false

    func requestObject<T>(_ endpoint: Endpoint, completion _: @escaping (APIResult<T>) -> Void) where T: Decodable {
        isRequestObjectCalled = true
    }
}
