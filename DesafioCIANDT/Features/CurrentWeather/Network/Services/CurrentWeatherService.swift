import CoreLocation
import Foundation

protocol CurrentWeatherService {
    func weather(for coordinates: CLLocationCoordinate2D, completion: @escaping (APIResult<WeatherOptions>) -> Void)
    func weatherList(for coordinates: CLLocationCoordinate2D, count: Int, completion: @escaping (APIResult<WeatherListResponse>) -> Void)
}

class APIClientCurrentWeatherService: CurrentWeatherService {
    let client: RequestClient

    init(client: RequestClient = APIClient()) {
        self.client = client
    }

    func weather(for coordinates: CLLocationCoordinate2D, completion: @escaping (APIResult<WeatherOptions>) -> Void) {
        var parameters = Parameters()
        parameters["lat"] = coordinates.latitude
        parameters["lon"] = coordinates.longitude
        parameters["appid"] = Settings.shared.appId
        parameters["units"] = "metric"

        let endpoint = SearchWeatherEndpoint(parameters: parameters)
        client.requestObject(endpoint, completion: completion)
    }

    func weatherList(for coordinates: CLLocationCoordinate2D, count: Int, completion: @escaping (APIResult<WeatherListResponse>) -> Void) {
        var parameters = Parameters()
        parameters["lat"] = coordinates.latitude
        parameters["lon"] = coordinates.longitude
        parameters["cnt"] = count
        parameters["appid"] = Settings.shared.appId
        parameters["units"] = "metric"

        let endpoint = SearchWeatherListEndpoint(parameters: parameters)
        client.requestObject(endpoint, completion: completion)
    }
}
