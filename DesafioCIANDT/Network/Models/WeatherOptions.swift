import Foundation

struct WeatherOptions: Decodable {
    let weather: [Weather]
    let wind: Wind
    let composition: WeatherComposition
    let name: String

    enum CodingKeys: String, CodingKey {
        case weather
        case wind
        case composition = "main"
        case name
    }
}
