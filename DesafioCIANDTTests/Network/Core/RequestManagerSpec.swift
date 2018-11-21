@testable import DesafioCIANDT
import Nimble
import Quick

class RequestManagerSpec: QuickSpec {
    override func spec() {
        describe("RequestManager") {
            let url = URL(string: "http://www.teste.com.br")!
            var response: DataResponse<Data>?
            var completionBlock: RequestCompletion!
            var sessionMock: URLSessionMock!
            var encodingMock: ParameterEncodingMock!
            var sut: RequestManager!

            beforeEach {
                completionBlock = { dataResponse in
                    response = dataResponse
                }

                encodingMock = ParameterEncodingMock()
                sessionMock = URLSessionMock()
                sut = RequestManager(session: sessionMock)
            }

            context("when request is called") {
                context("with data") {
                    beforeEach {
                        sessionMock.data = Data()
                        sessionMock.urlResponse = HTTPURLResponse.mock()

                        sut.request(method: HTTPMethod.post, url: url, encoding: encodingMock, completion: completionBlock)
                    }

                    it("should create the request properly") {
                        expect(sessionMock.request?.url?.absoluteString).to(equal("http://www.teste.com.br"))
                        expect(sessionMock.request?.httpMethod).to(equal("POST"))
                    }

                    it("should call encode from encoding") {
                        expect(encodingMock.isEncodeCalled).to(beTrue())
                    }

                    it("should call completionBlock with success") {
                        expect(response).toEventuallyNot(beNil())
                        expect(response?.result == Result.success(Data())).to(beTrue())
                    }
                }

                context("with error") {
                    beforeEach {
                        sessionMock.data = nil
                        sessionMock.urlResponse = HTTPURLResponse.mock()
                        sessionMock.error = ErrorMock()

                        sut.request(method: HTTPMethod.get, url: url, encoding: encodingMock, completion: completionBlock)
                    }

                    it("should create the request properly") {
                        expect(sessionMock.request?.url?.absoluteString).to(equal("http://www.teste.com.br"))
                        expect(sessionMock.request?.httpMethod).to(equal("GET"))
                    }

                    it("should call encode from encoding") {
                        expect(encodingMock.isEncodeCalled).to(beTrue())
                    }

                    it("should call completionBlock with success") {
                        expect(response).toEventuallyNot(beNil())
                        expect(response?.result == Result.failure(ErrorMock())).to(beTrue())
                    }
                }

                context("with no error and data nil") {
                    beforeEach {
                        sessionMock.data = nil
                        sessionMock.urlResponse = HTTPURLResponse.mock()
                        sessionMock.error = nil

                        sut.request(method: HTTPMethod.get, url: url, encoding: encodingMock, completion: completionBlock)
                    }

                    it("should create the request properly") {
                        expect(sessionMock.request?.url?.absoluteString).to(equal("http://www.teste.com.br"))
                        expect(sessionMock.request?.httpMethod).to(equal("GET"))
                    }

                    it("should call encode from encoding") {
                        expect(encodingMock.isEncodeCalled).to(beTrue())
                    }

                    it("should call completionBlock with success") {
                        expect(response).toEventuallyNot(beNil())
                        expect(response?.result == Result.failure(ErrorMock())).to(beTrue())
                    }
                }
            }
        }
    }
}
