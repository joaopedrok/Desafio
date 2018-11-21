@testable import DesafioCIANDT
import Foundation

class CurrentWeatherViewPresenterMock: CurrentWeatherViewPresenter {
    weak var currentWeatherViewController: CurrentWeatherViewController?

    var isDidFinishViewDidLoadCalled = false
    var isDidTouchSeeNearbyWeathersCalled = false

    func didFinishViewDidLoad() {
        isDidFinishViewDidLoadCalled = true
    }

    func didTouchSeeNearbyWeathers() {
        isDidTouchSeeNearbyWeathersCalled = true
    }
}
