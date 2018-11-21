import CoreLocation
import Foundation

enum LocationResult {
    case success(CLLocationCoordinate2D)
    case invalid
}

typealias LocationManagerCompletion = (LocationResult) -> Void

protocol UserLocationManager {
    func fetchUserLocation(_ completion: @escaping LocationManagerCompletion)
}

class LocationManager: NSObject, UserLocationManager {
    static let shared = LocationManager()

    private var didUpdatedLocation = false
    private let manager: CLLocationManager
    fileprivate var locationManagerCompletion: LocationManagerCompletion?

    override init() {
        manager = CLLocationManager()
        super.init()
        manager.delegate = self
        manager.activityType = .other
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func fetchUserLocation(_ completion: @escaping LocationManagerCompletion) {
        locationManagerCompletion = completion

        if CLLocationManager.authorizationStatus() != .authorizedAlways &&
            CLLocationManager.authorizationStatus() != .authorizedWhenInUse {
            if CLLocationManager.authorizationStatus() == .notDetermined {
                manager.requestWhenInUseAuthorization()
            } else {
                locationManagerCompletion?(.invalid)
            }
        } else {
            didUpdatedLocation = false
            manager.startUpdatingLocation()
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization _: CLAuthorizationStatus) {
        didUpdatedLocation = false
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()

        if let location = locations.last {
            if !didUpdatedLocation {
                let userLocation = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                          longitude: location.coordinate.longitude)
                didUpdatedLocation = true
                locationManagerCompletion?(.success(userLocation))
            }
        } else {
            locationManagerCompletion?(.invalid)
            manager.requestWhenInUseAuthorization()
        }
    }
}
