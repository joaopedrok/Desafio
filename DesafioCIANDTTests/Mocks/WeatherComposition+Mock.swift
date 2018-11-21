@testable import DesafioCIANDT
import Foundation

extension WeatherComposition {
    static func mock() -> WeatherComposition {
        return WeatherComposition(temperature: 50,
                                  pressure: 2.5,
                                  humidity: 80,
                                  minimumTemperature: 25,
                                  maximumTemperature: 30)
    }
}
