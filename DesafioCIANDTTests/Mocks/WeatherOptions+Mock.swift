@testable import DesafioCIANDT
import Foundation

extension WeatherOptions {
    static func mock() -> WeatherOptions {
        return WeatherOptions(weather: [Weather.mock()],
                              wind: Wind.mock(),
                              composition: WeatherComposition.mock(),
                              name: "Belo Horizonte")
    }
}
