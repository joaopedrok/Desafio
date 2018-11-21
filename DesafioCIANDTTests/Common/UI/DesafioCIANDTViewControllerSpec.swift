@testable import DesafioCIANDT
import MBProgressHUD
import Nimble
import Quick

class DesafioCIANDTViewControllerSpec: QuickSpec {
    override func spec() {
        describe("DesafioCIANDTViewController") {
            var navigation: NavigationControllerMock!
            var sut: DesafioCIANDTViewController!

            beforeEach {
                sut = DesafioCIANDTViewController()
                navigation = NavigationControllerMock(rootViewController: sut)
                _ = sut.view
            }

            context("when its loaded") {
                it("should hide back button title") {
                    expect(sut.navigationItem.backBarButtonItem?.title).to(equal(""))
                }
            }

            context("when showLoading is called") {
                beforeEach {
                    sut.showLoading()
                }

                it("should add a hud") {
                    expect(MBProgressHUD(for: sut.view)).toNot(beNil())
                }
            }

            context("when hideLoading is called") {
                beforeEach {
                    sut.showLoading()
                    sut.hideLoading()
                }

                it("should not let a hud") {
                    expect(MBProgressHUD(for: sut.view)).to(beNil())
                }
            }

            context("when pushViewController is called") {
                beforeEach {
                    sut.pushViewController(viewController: UIViewController())
                }

                it("should call pushViewController from navigationController") {
                    expect(navigation.isPushViewControllerCalled).to(beTrue())
                }
            }
        }
    }
}
