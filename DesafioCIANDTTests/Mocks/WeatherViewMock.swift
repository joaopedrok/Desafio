@testable import DesafioCIANDT
import UIKit

class WeatherViewMock: WeatherView {
    var isSetWeatherOptionsCalled = false

    override func setWeatherOptions(weatherOptions _: WeatherOptions) {
        isSetWeatherOptionsCalled = true
    }
}
