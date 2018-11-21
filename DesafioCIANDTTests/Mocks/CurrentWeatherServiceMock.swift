import CoreLocation
@testable import DesafioCIANDT
import Foundation

class CurrentWeatherServiceMock: CurrentWeatherService {
    var weatherResult: APIResult<WeatherOptions>?
    var weatherListResult: APIResult<WeatherListResponse>?

    func weather(for _: CLLocationCoordinate2D, completion: @escaping (APIResult<WeatherOptions>) -> Void) {
        if let weatherResult = weatherResult {
            completion(weatherResult)
        }
    }

    func weatherList(for _: CLLocationCoordinate2D, count _: Int, completion: @escaping (APIResult<WeatherListResponse>) -> Void) {
        if let weatherListResult = weatherListResult {
            completion(weatherListResult)
        }
    }
}
