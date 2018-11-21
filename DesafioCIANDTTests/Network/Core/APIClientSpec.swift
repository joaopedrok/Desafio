@testable import DesafioCIANDT
import Nimble
import Quick

struct ModelTest: Codable {
    var name: String
    var age: Int
}

struct EndpointTest: Endpoint {
    var baseURL: URL {
        return URL(string: "http://www.teste.com.br")!
    }

    var method: HTTPMethod {
        return .get
    }

    var parameters: Parameters?

    var path: String {
        return "flash"
    }

    var parameterEncoding: ParameterEncoding = URLEncoding()
}

class APIClientSpec: QuickSpec {
    override func spec() {
        describe("APIClient") {
            var requestManagerMock: RequestManagerMock!
            var sut: APIClient!

            beforeEach {
                requestManagerMock = RequestManagerMock()
                sut = APIClient(requestManagerMock)
            }

            context("when request is called") {
                context("with success object") {
                    beforeEach {
                        let modelTest = ModelTest(name: "Joao", age: 28)
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try! jsonEncoder.encode(modelTest)
                        requestManagerMock.dataResponseResult = DataResponse(result: Result.success(jsonData), response: HTTPURLResponse.mock())
                    }

                    it("should call completion with success") {
                        let modelTest = ModelTest(name: "Joao", age: 28)
                        sut.requestObject(EndpointTest(), completion: { (apiResult: APIResult<ModelTest>) in
                            expect(apiResult == APIResult.success(modelTest)).to(beTrue())
                        })
                    }
                }

                context("with failure object") {
                    beforeEach {
                        let data = "{ name: \"Joao\", gender: \"male\" }".data(using: .utf8)!
                        requestManagerMock.dataResponseResult = DataResponse(result: Result.success(data), response: HTTPURLResponse.mock())
                    }

                    it("should call completion with failure") {
                        sut.requestObject(EndpointTest(), completion: { (apiResult: APIResult<ModelTest>) in
                            expect(apiResult).to(equal(APIResult.failure(APIError.parseError(errorMessage: "Fail to parse object"))))
                        })
                    }
                }

                context("with failure result") {
                    context("with HTTPURLResponse") {
                        beforeEach {
                            let error = NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Error"])
                            requestManagerMock.dataResponseResult = DataResponse(result: Result.failure(error), response: HTTPURLResponse.mock())
                        }

                        it("should call completion with failure") {
                            sut.requestObject(EndpointTest(), completion: { (apiResult: APIResult<ModelTest>) in
                                expect(apiResult).to(equal(APIResult.failure(APIError.apiError(statusCode: 404, errorMessage: "Error"))))
                            })
                        }
                    }

                    context("with no HTTPURLResponse") {
                        beforeEach {
                            requestManagerMock.dataResponseResult = DataResponse(result: Result.failure(ErrorMock()), response: nil)
                        }

                        it("should call completion with failure") {
                            sut.requestObject(EndpointTest(), completion: { (apiResult: APIResult<ModelTest>) in
                                expect(apiResult).to(equal(APIResult.failure(APIError.networkError(errorMessage: "Connection error. Try again later"))))
                            })
                        }
                    }
                }
            }
        }
    }
}
