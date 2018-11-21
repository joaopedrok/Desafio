@testable import DesafioCIANDT
import UIKit

class CurrentWeatherViewControllerMock: CurrentWeatherViewController {
    var isShowLoadingCalled = false
    var isHideLoadingCalled = false
    var isShowErrorCalled = false
    var isSetWeatherOptionsCalled = false
    var isSetUserNameCalled = false

    override func showLoading() {
        isShowLoadingCalled = true
    }

    override func hideLoading() {
        isHideLoadingCalled = true
    }

    override func showError(message _: String) {
        isShowErrorCalled = true
    }

    override func setWeatherOptions(weatherOptions _: WeatherOptions) {
        isSetWeatherOptionsCalled = true
    }

    override func setUserName(name _: String) {
        isSetUserNameCalled = true
    }
}
