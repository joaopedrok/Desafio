@testable import DesafioCIANDT
import Nimble
import Quick

class SearchWeatherEndpointSpec: QuickSpec {
    override func spec() {
        describe("SearchWeatherEndpoint") {
            var sut: SearchWeatherEndpoint!

            beforeEach {
                sut = SearchWeatherEndpoint()
            }

            it("should configure all properties ") {
                expect(sut.baseURL.absoluteString).to(equal(Settings.shared.apiURL))
                expect(sut.parameterEncoding).to(beAKindOf(URLEncoding.self))
                expect(sut.method).to(equal(HTTPMethod.get))
                expect(sut.parameters).to(beNil())
                expect(sut.path).to(equal("weather"))
            }
        }
    }
}
