@testable import DesafioCIANDT
import Nimble
import Quick

class CurrentWeatherViewControllerSpec: QuickSpec {
    override func spec() {
        describe("CurrentWeatherViewController") {
            var presenterMock: CurrentWeatherViewPresenterMock!
            var sut: CurrentWeatherViewController!

            beforeEach {
                presenterMock = CurrentWeatherViewPresenterMock()
                sut = CurrentWeatherViewController(presenter: presenterMock)
                _ = sut.view
            }

            context("when its instantiated") {
                it("should set presenter") {
                    expect(sut.presenter).toNot(beNil())
                }

                it("should set controller from presenter") {
                    expect(sut.presenter?.currentWeatherViewController).toNot(beNil())
                }
            }

            context("when its loaded") {
                it("should configureView") {
                    expect(sut.view.backgroundColor?.cgColor).to(equal(UIColor.lightGray.cgColor))
                }

                it("should configure viewWeather") {
                    expect(sut.viewWeather.superview).to(equal(sut.view))
                }

                it("should configure buttonWeatherList") {
                    expect(sut.buttonWeatherList.target(forAction: #selector(sut.seeNearbyWeather), withSender: sut.buttonWeatherList)).toNot(beNil())
                    expect(sut.buttonWeatherList.title(for: .normal)).to(equal("See nearby cities"))
                    expect(sut.buttonWeatherList.superview).to(equal(sut.view))
                }

                it("should call didFinishViewDidLoad from presenter") {
                    expect(presenterMock.isDidFinishViewDidLoadCalled).to(beTrue())
                }
            }

            context("when seeNearbyWeather is called") {
                beforeEach {
                    sut.seeNearbyWeather()
                }

                it("should call didTouchSeeNearbyWeathers from presenter") {
                    expect(presenterMock.isDidTouchSeeNearbyWeathersCalled).to(beTrue())
                }
            }

            context("when setWeatherOptions is called") {
                var weatherViewMock: WeatherViewMock!

                beforeEach {
                    weatherViewMock = WeatherViewMock()
                    sut.viewWeather = weatherViewMock
                    sut.setWeatherOptions(weatherOptions: WeatherOptions.mock())
                }

                it("should call setWeatherOptions from viewWeather") {
                    expect(weatherViewMock.isSetWeatherOptionsCalled).to(beTrue())
                }
            }
        }
    }
}
