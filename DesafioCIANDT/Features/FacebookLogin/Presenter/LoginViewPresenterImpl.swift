import FBSDKCoreKit
import FBSDKLoginKit
import Foundation

class LoginViewPresenterImpl: LoginViewPresenter {
    weak var loginViewController: LoginViewController?

    func didFinishViewDidLoad() {
        loginViewController?.title = "Login"
    }

    func didCompleteFacebookLogin() {
        FBSDKProfile.loadCurrentProfile { profile, error in
            if let error = error {
                self.loginViewController?.showError(message: error.localizedDescription)
            } else if let profile = profile {
                self.pushCurrentWeatherViewController(userName: "Welcome " + profile.firstName)
            }
        }
    }

    private func pushCurrentWeatherViewController(userName: String) {
        let presenter = CurrentWeatherViewPresenterImpl(userName: userName,
                                                        service: APIClientCurrentWeatherService(),
                                                        locationManager: LocationManager())

        let currentWeatherViewController = CurrentWeatherViewController(presenter: presenter)
        loginViewController?.navigationController?.setViewControllers([currentWeatherViewController], animated: true)
    }
}
