import Foundation

struct WeatherListResponse: Decodable {
    let list: [WeatherOptions]
}
