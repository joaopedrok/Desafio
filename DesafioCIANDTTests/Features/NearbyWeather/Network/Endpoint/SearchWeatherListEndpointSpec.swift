@testable import DesafioCIANDT
import Nimble
import Quick

class SearchWeatherListEndpointSpec: QuickSpec {
    override func spec() {
        describe("SearchWeatherListEndpoint") {
            var sut: SearchWeatherListEndpoint!

            beforeEach {
                sut = SearchWeatherListEndpoint()
            }

            it("should configure all properties ") {
                expect(sut.baseURL.absoluteString).to(equal(Settings.shared.apiURL))
                expect(sut.parameterEncoding).to(beAKindOf(URLEncoding.self))
                expect(sut.method).to(equal(HTTPMethod.get))
                expect(sut.parameters).to(beNil())
                expect(sut.path).to(equal("find"))
            }
        }
    }
}
