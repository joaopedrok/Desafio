import CoreLocation
@testable import DesafioCIANDT
import Nimble
import Quick

class NearbyWeatherViewPresenterImplSpec: QuickSpec {
    override func spec() {
        describe("NearbyWeatherViewPresenterImpl") {
            var serviceMock: CurrentWeatherServiceMock!
            var sut: NearbyWeatherViewPresenterImpl!

            beforeEach {
                serviceMock = CurrentWeatherServiceMock()
                sut = NearbyWeatherViewPresenterImpl(coordinates: CLLocationCoordinate2D(latitude: 20, longitude: 200),
                                                     service: serviceMock)
            }

            context("when its instantiated") {
                it("should set all properties") {
                    expect(sut.coordinates).toNot(beNil())
                    expect(sut.service).toNot(beNil())
                }
            }

            context("when didFinishViewDidLoad is called") {
                var nearbyWeatherViewControllerMock: NearbyWeatherViewControllerMock!

                beforeEach {
                    nearbyWeatherViewControllerMock = NearbyWeatherViewControllerMock(presenter: sut)
                }

                context("with success") {
                    beforeEach {
                        serviceMock.weatherListResult = APIResult.success(WeatherListResponse.mock())
                        sut.didFinishViewDidLoad()
                    }

                    it("should change controller title") {
                        expect(nearbyWeatherViewControllerMock.title).to(equal("Nearby Cities"))
                    }

                    it("should call showLoading") {
                        expect(nearbyWeatherViewControllerMock.isShowLoadingCalled).to(beTrue())
                    }

                    it("should call hideLoading") {
                        expect(nearbyWeatherViewControllerMock.isHideLoadingCalled).to(beTrue())
                    }

                    it("should call setWeatherList from controller") {
                        expect(nearbyWeatherViewControllerMock.isSetWeatherListCalled).to(beTrue())
                    }
                }

                context("with failure") {
                    beforeEach {
                        serviceMock.weatherListResult = APIResult.failure(APIError.networkError(errorMessage: "Error"))
                        sut.didFinishViewDidLoad()
                    }

                    it("should change controller title") {
                        expect(nearbyWeatherViewControllerMock.title).to(equal("Nearby Cities"))
                    }

                    it("should call showLoading") {
                        expect(nearbyWeatherViewControllerMock.isShowLoadingCalled).to(beTrue())
                    }

                    it("should call hideLoading") {
                        expect(nearbyWeatherViewControllerMock.isHideLoadingCalled).to(beTrue())
                    }

                    it("should call showError") {
                        expect(nearbyWeatherViewControllerMock.isShowErrorCalled).to(beTrue())
                    }
                }
            }
        }
    }
}
