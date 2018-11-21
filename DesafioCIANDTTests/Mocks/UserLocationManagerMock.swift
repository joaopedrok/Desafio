@testable import DesafioCIANDT
import Foundation

class UserLocationManagerMock: UserLocationManager {
    var locationResult: LocationResult?
    var isFetchUserLocationCalled = false

    func fetchUserLocation(_ completion: @escaping LocationManagerCompletion) {
        isFetchUserLocationCalled = true

        if let result = locationResult {
            completion(result)
        }
    }
}
