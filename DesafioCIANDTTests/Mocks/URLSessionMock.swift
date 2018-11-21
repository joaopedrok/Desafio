import Foundation

class URLSessionDataTaskMock: URLSessionDataTask {
    var isResumeCalled = false

    override func resume() {
        isResumeCalled = true
    }
}

class URLSessionMock: URLSession {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    var dataTaskMock = URLSessionDataTaskMock()
    var request: URLRequest?

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        self.request = request

        completionHandler(data, urlResponse, error)

        return dataTaskMock
    }
}
