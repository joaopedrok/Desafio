@testable import DesafioCIANDT
import Nimble
import Nimble_Snapshots
import Quick

class WeatherCellSpec: QuickSpec {
    override func spec() {
        describe("WeatherCell") {
            var sut: WeatherCell!

            beforeEach {
                sut = WeatherCell(frame: .zero)
                let newSize = SizeHelper.size(for: sut)
                sut.frame = CGRect(x: 0, y: 0, width: 320, height: newSize.height)
                sut.setWeatherOptions(weatherOptions: WeatherOptions.mock())
            }

            context("when its instantiated") {
                it("should build layout properly") {
                    expect(sut) == snapshot()
                }
            }
        }
    }
}
