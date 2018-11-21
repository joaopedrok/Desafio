import CoreLocation
import Foundation

class CurrentWeatherViewPresenterImpl: CurrentWeatherViewPresenter {
    weak var currentWeatherViewController: CurrentWeatherViewController?

    let userName: String
    let service: CurrentWeatherService
    let locationManager: UserLocationManager

    private var coordinates: CLLocationCoordinate2D?

    init(userName: String,
         service: CurrentWeatherService,
         locationManager: UserLocationManager) {
        self.userName = userName
        self.service = service
        self.locationManager = locationManager
    }

    func didFinishViewDidLoad() {
        currentWeatherViewController?.title = "Weather"
        currentWeatherViewController?.setUserName(name: userName)

        fetchUserLocation()
    }

    func didTouchSeeNearbyWeathers() {
        if let coordinates = coordinates {
            pushNeabyWeatherViewController(coordinates: coordinates)
        }
    }

    private func fetchUserLocation() {
        locationManager.fetchUserLocation { result in
            switch result {
            case let .success(coordinates):
                self.coordinates = coordinates
                self.fetchWeather(coordinates)
            case .invalid:
                self.currentWeatherViewController?.showError(message: "Fail to retrive user location")
            }
        }
    }

    private func fetchWeather(_ coordinates: CLLocationCoordinate2D) {
        currentWeatherViewController?.showLoading()

        service.weather(for: coordinates) { apiResult in
            self.currentWeatherViewController?.hideLoading()

            switch apiResult {
            case let .success(weatherOptions):
                self.currentWeatherViewController?.setWeatherOptions(weatherOptions: weatherOptions)
            case let .failure(error):
                self.currentWeatherViewController?.showError(message: error.localizedDescription)
            }
        }
    }

    private func pushNeabyWeatherViewController(coordinates: CLLocationCoordinate2D) {
        let presenter = NearbyWeatherViewPresenterImpl(coordinates: coordinates,
                                                       service: APIClientCurrentWeatherService())

        let nearbyWeatherViewController = NearbyWeatherViewController(presenter: presenter)
        currentWeatherViewController?.pushViewController(viewController: nearbyWeatherViewController)
    }
}
