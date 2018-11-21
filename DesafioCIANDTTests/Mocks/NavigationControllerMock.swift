import UIKit

class NavigationControllerMock: UINavigationController {
    var isPushViewControllerCalled = false
    var isPopViewControllerCalled = false

    override func pushViewController(_: UIViewController, animated _: Bool) {
        isPushViewControllerCalled = true
    }
}
