@testable import DesafioCIANDT
import Foundation

extension WeatherListResponse {
    static func mock() -> WeatherListResponse {
        return WeatherListResponse(list: [WeatherOptions.mock(), WeatherOptions.mock()])
    }
}
