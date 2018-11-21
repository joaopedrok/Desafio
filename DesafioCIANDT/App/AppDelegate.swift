import FBSDKCoreKit
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance()?.application(application, didFinishLaunchingWithOptions: launchOptions)

        setupRootViewController()

        return true
    }

    func application(_ app: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance()!.application(app, open: url, sourceApplication: sourceApplication!, annotation: annotation)
    }

    private func setupRootViewController() {
        if FBSDKAccessToken.current() != nil {
            FBSDKProfile.loadCurrentProfile { profile, error in
                if error != nil {
                    self.setupRootViewController()
                } else if let profile = profile {
                    self.setupCurrentWeatherViewController(userName: profile.firstName)
                }
            }
        } else {
            setupLoginViewController()
        }
    }

    private func setupLoginViewController() {
        let presenter = LoginViewPresenterImpl()
        let loginViewController = LoginViewController(presenter: presenter)

        let navigationController = UINavigationController(rootViewController: loginViewController)

        setupWindow(rootViewController: navigationController)
    }

    private func setupCurrentWeatherViewController(userName: String) {
        let presenter = CurrentWeatherViewPresenterImpl(userName: userName,
                                                        service: APIClientCurrentWeatherService(),
                                                        locationManager: LocationManager.shared)
        let currentWeatherViewController = CurrentWeatherViewController(presenter: presenter)

        let navigationController = UINavigationController(rootViewController: currentWeatherViewController)

        setupWindow(rootViewController: navigationController)
    }

    private func setupWindow(rootViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
