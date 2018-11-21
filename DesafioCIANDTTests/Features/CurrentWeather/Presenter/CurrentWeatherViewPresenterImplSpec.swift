import CoreLocation
@testable import DesafioCIANDT
import Nimble
import Quick

class CurrentWeatherViewPresenterImplSpec: QuickSpec {
    override func spec() {
        describe("CurrentWeatherViewPresenterImpl") {
            var serviceMock: CurrentWeatherServiceMock!
            var locationManagerMock: UserLocationManagerMock!
            var sut: CurrentWeatherViewPresenterImpl!

            beforeEach {
                serviceMock = CurrentWeatherServiceMock()
                locationManagerMock = UserLocationManagerMock()
                sut = CurrentWeatherViewPresenterImpl(userName: "João", service: serviceMock,
                                                      locationManager: locationManagerMock)
            }

            context("when its instantiated") {
                it("should set all properties") {
                    expect(sut.service).toNot(beNil())
                    expect(sut.locationManager).toNot(beNil())
                }
            }

            context("when didFinishViewDidLoad called") {
                var currentWeatherViewControllerMock: CurrentWeatherViewControllerMock!

                beforeEach {
                    currentWeatherViewControllerMock = CurrentWeatherViewControllerMock(presenter: sut)
                }

                context("with invalid location") {
                    beforeEach {
                        locationManagerMock.locationResult = .invalid
                        sut.didFinishViewDidLoad()
                    }

                    it("should call setUserName") {
                        expect(currentWeatherViewControllerMock.isSetUserNameCalled).to(beTrue())
                    }

                    it("should call showError") {
                        expect(currentWeatherViewControllerMock.isShowErrorCalled).to(beTrue())
                    }

                    it("should change controller title") {
                        expect(currentWeatherViewControllerMock.title).to(equal("Weather"))
                    }
                }

                context("with valid location") {
                    beforeEach {
                        let coordinates = CLLocationCoordinate2D(latitude: 32, longitude: 50)
                        locationManagerMock.locationResult = .success(coordinates)
                    }

                    context("with success fetching data") {
                        beforeEach {
                            serviceMock.weatherResult = APIResult<WeatherOptions>.success(WeatherOptions.mock())
                            sut.didFinishViewDidLoad()
                        }

                        it("should call setUserName") {
                            expect(currentWeatherViewControllerMock.isSetUserNameCalled).to(beTrue())
                        }

                        it("should call showLoading") {
                            expect(currentWeatherViewControllerMock.isShowLoadingCalled).to(beTrue())
                        }

                        it("should call hideLoading") {
                            expect(currentWeatherViewControllerMock.isHideLoadingCalled).to(beTrue())
                        }

                        it("should call setWeatherOptions from controller") {
                            expect(currentWeatherViewControllerMock.isSetWeatherOptionsCalled).to(beTrue())
                        }

                        it("should change controller title") {
                            expect(currentWeatherViewControllerMock.title).to(equal("Weather"))
                        }
                    }

                    context("with failure fetching data") {
                        beforeEach {
                            serviceMock.weatherResult = APIResult<WeatherOptions>.failure(APIError.networkError(errorMessage: "Error"))
                            sut.didFinishViewDidLoad()
                        }

                        it("should call setUserName") {
                            expect(currentWeatherViewControllerMock.isSetUserNameCalled).to(beTrue())
                        }

                        it("should call showLoading") {
                            expect(currentWeatherViewControllerMock.isShowLoadingCalled).to(beTrue())
                        }

                        it("should call hideLoading") {
                            expect(currentWeatherViewControllerMock.isHideLoadingCalled).to(beTrue())
                        }

                        it("should call showError") {
                            expect(currentWeatherViewControllerMock.isShowErrorCalled).to(beTrue())
                        }

                        it("should change controller title") {
                            expect(currentWeatherViewControllerMock.title).to(equal("Weather"))
                        }
                    }
                }
            }
        }
    }
}
