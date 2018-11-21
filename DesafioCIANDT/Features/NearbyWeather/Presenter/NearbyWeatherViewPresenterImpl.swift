import CoreLocation
import Foundation

class NearbyWeatherViewPresenterImpl: NearbyWeatherViewPresenter {
    weak var nearbyWeatherViewController: NearbyWeatherViewController?

    let coordinates: CLLocationCoordinate2D
    let service: CurrentWeatherService

    init(coordinates: CLLocationCoordinate2D,
         service: CurrentWeatherService) {
        self.coordinates = coordinates
        self.service = service
    }

    func didFinishViewDidLoad() {
        nearbyWeatherViewController?.title = "Nearby Cities"

        fetchWeatherList()
    }

    private func fetchWeatherList() {
        nearbyWeatherViewController?.showLoading()

        service.weatherList(for: coordinates, count: 10) { apiResult in
            self.nearbyWeatherViewController?.hideLoading()

            switch apiResult {
            case let .success(weatherListResponse):
                self.nearbyWeatherViewController?.setWeatherList(weatherList: weatherListResponse.list)

            case let .failure(error):
                self.nearbyWeatherViewController?.showError(message: error.localizedDescription)
            }
        }
    }
}
