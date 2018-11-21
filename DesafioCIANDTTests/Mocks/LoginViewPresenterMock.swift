@testable import DesafioCIANDT
import Foundation

class LoginViewPresenterMock: LoginViewPresenter {
    weak var loginViewController: LoginViewController?

    var isDidFinishViewDidLoadCalled = false
    var isDidCompleteFacebookLoginCalled = false

    func didFinishViewDidLoad() {
        isDidFinishViewDidLoadCalled = true
    }

    func didCompleteFacebookLogin() {
        isDidCompleteFacebookLoginCalled = true
    }
}
