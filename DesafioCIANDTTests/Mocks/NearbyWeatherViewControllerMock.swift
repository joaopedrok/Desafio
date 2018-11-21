@testable import DesafioCIANDT
import UIKit

class NearbyWeatherViewControllerMock: NearbyWeatherViewController {
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var isShowErrorCalled = false
    var isSetWeatherListCalled = false

    override func showLoading() {
        isShowLoadingCalled = true
    }

    override func hideLoading() {
        isHideLoadingCalled = true
    }

    override func showError(message _: String) {
        isShowErrorCalled = true
    }

    override func setWeatherList(weatherList _: [WeatherOptions]) {
        isSetWeatherListCalled = true
    }
}
