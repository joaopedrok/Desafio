@testable import DesafioCIANDT
import Nimble
import Quick

class URLEncodingSpec: QuickSpec {
    override func spec() {
        describe("URLEncoding") {
            var sut: URLEncoding!

            beforeEach {
                sut = URLEncoding()
            }

            context("when encode is called") {
                var urlRequest: URLRequest!

                context("with parameters without space") {
                    beforeEach {
                        let url = URL(string: "http://www.teste.com.br")!
                        urlRequest = URLRequest(url: url)

                        var parameters = Parameters()
                        parameters["teste"] = "bla1"
                        parameters["teste2"] = "bla2"

                        urlRequest = sut.encode(url: urlRequest, parameters: parameters)
                    }

                    it("should set parameters at url") {
                        expect(urlRequest.url?.absoluteString).to(equal("http://www.teste.com.br?teste=bla1&teste2=bla2"))
                    }
                }

                context("with parameters with space") {
                    beforeEach {
                        let url = URL(string: "http://www.teste.com.br")!
                        urlRequest = URLRequest(url: url)

                        var parameters = Parameters()
                        parameters["teste"] = "bla1 bla3"
                        parameters["teste2"] = "bla2"

                        urlRequest = sut.encode(url: urlRequest, parameters: parameters)
                    }

                    it("should set parameters at url") {
                        expect(urlRequest.url?.absoluteString).to(equal("http://www.teste.com.br?teste=bla1%20bla3&teste2=bla2"))
                    }
                }
            }
        }
    }
}
