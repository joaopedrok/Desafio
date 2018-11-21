@testable import DesafioCIANDT
import Nimble
import Nimble_Snapshots
import Quick

class WeatherViewSpec: QuickSpec {
    override func spec() {
        describe("WeatherView") {
            var sut: WeatherView!

            beforeEach {
                sut = WeatherView()
                let size = SizeHelper.size(for: sut)
                sut.frame = CGRect(x: 0, y: 0, width: 320, height: size.height)
                sut.setWeatherOptions(weatherOptions: WeatherOptions.mock())
            }

            context("when its instantiated") {
                it("should configure view properly") {
                    expect(sut) == snapshot()
                }
            }
        }
    }
}
