import Foundation

struct WeatherComposition: Decodable {
    let temperature: Double
    let pressure: Double
    let humidity: Double
    let minimumTemperature: Double
    let maximumTemperature: Double

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
        case minimumTemperature = "temp_min"
        case maximumTemperature = "temp_max"
    }
}
