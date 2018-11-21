@testable import DesafioCIANDT
import FBSDKLoginKit
import Nimble
import Quick

class LoginViewControllerSpec: QuickSpec {
    override func spec() {
        describe("LoginViewController") {
            var presenterMock: LoginViewPresenterMock!
            var sut: LoginViewController!

            beforeEach {
                presenterMock = LoginViewPresenterMock()
                sut = LoginViewController(presenter: presenterMock)
                _ = sut.view
            }

            context("when its instantiated") {
                it("should set presenter") {
                    expect(sut.presenter).toNot(beNil())
                }

                it("should set controller from presenter") {
                    expect(sut.presenter?.loginViewController).toNot(beNil())
                }
            }

            context("when its loaded") {
                it("should configureView") {
                    expect(sut.view.backgroundColor?.cgColor).to(equal(UIColor.white.cgColor))
                }

                it("should configure buttonFacebook") {
                    expect(sut.buttonFacebook.readPermissions.count).to(equal(1))
                    expect(sut.buttonFacebook.delegate).toNot(beNil())
                    expect(sut.buttonFacebook.superview).to(equal(sut.view))
                }
            }

            context("when didCompleteWith is called") {
                beforeEach {
                    let token = FBSDKAccessToken(tokenString: "token", permissions: [], declinedPermissions: [], appID: "appId", userID: "userId", expirationDate: Date(), refreshDate: Date())
                    let result = FBSDKLoginManagerLoginResult(token: token, isCancelled: false, grantedPermissions: [], declinedPermissions: [])
                    sut.loginButton(sut.buttonFacebook, didCompleteWith: result, error: ErrorMock())
                }

                it("should call didCompleteFacebookLogin from presenter") {
                    expect(presenterMock.isDidCompleteFacebookLoginCalled).to(beTrue())
                }
            }
        }
    }
}
