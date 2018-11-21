import CoreLocation
@testable import DesafioCIANDT
import Nimble
import Quick

class APIClientCurrentWeatherServiceeSpec: QuickSpec {
    override func spec() {
        describe("APIClientCurrentWeatherService") {
            var requestMock: RequestClientMock!
            var sut: APIClientCurrentWeatherService!

            beforeEach {
                requestMock = RequestClientMock()
                sut = APIClientCurrentWeatherService(client: requestMock)
            }

            context("when weather is called") {
                beforeEach {
                    sut.weather(for: CLLocationCoordinate2D(latitude: 10, longitude: 200),
                                completion: { _ in })
                }

                it("should call requestObject") {
                    expect(requestMock.isRequestObjectCalled).to(beTrue())
                }
            }

            context("when weatherList is called") {
                beforeEach {
                    sut.weatherList(for: CLLocationCoordinate2D(latitude: 10, longitude: 200),
                                    count: 10,
                                    completion: { _ in })
                }

                it("should call requestObject") {
                    expect(requestMock.isRequestObjectCalled).to(beTrue())
                }
            }
        }
    }
}
