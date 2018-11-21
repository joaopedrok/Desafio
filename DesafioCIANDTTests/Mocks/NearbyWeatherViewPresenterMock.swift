@testable import DesafioCIANDT
import UIKit

class NearbyWeatherViewPresenterMock: NearbyWeatherViewPresenter {
    weak var nearbyWeatherViewController: NearbyWeatherViewController?

    var isDidFinishViewDidLoadCalled = false

    func didFinishViewDidLoad() {
        isDidFinishViewDidLoadCalled = true
    }
}
