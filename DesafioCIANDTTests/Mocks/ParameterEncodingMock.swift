import Foundation
@testable import DesafioCIANDT

class ParameterEncodingMock: ParameterEncoding {
    var isEncodeCalled = false

    func encode(url: URLRequest, parameters _: Parameters?) -> URLRequest {
        isEncodeCalled = true

        return url
    }
}
