import Foundation

extension HTTPURLResponse {
    class func mock() -> HTTPURLResponse {
        let url = URL(string: "http://www.teste.com.br")!
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
}
