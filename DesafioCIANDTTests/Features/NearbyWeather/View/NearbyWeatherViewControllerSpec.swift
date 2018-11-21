@testable import DesafioCIANDT
import Nimble
import Quick

class NearbyWeatherViewControllerSpec: QuickSpec {
    override func spec() {
        describe("NearbyWeatherViewController") {
            var presenterMock: NearbyWeatherViewPresenterMock!
            var sut: NearbyWeatherViewController!

            beforeEach {
                presenterMock = NearbyWeatherViewPresenterMock()
                sut = NearbyWeatherViewController(presenter: presenterMock)
                _ = sut.view
            }

            context("when its instantiated") {
                it("should set presenter") {
                    expect(sut.presenter).toNot(beNil())
                }

                it("should set controller from presenter") {
                    expect(sut.presenter?.nearbyWeatherViewController).toNot(beNil())
                }
            }

            context("when its loaded") {
                it("should configureView") {
                    expect(sut.view.backgroundColor?.cgColor).to(equal(UIColor.lightGray.cgColor))
                }

                it("should configure collectionView") {
                    let layout = sut.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
                    expect(layout.scrollDirection).to(equal(.horizontal))
                    expect(layout.minimumInteritemSpacing).to(equal(20))

                    expect(sut.collectionView.backgroundColor?.cgColor).to(equal(UIColor.lightGray.cgColor))
                    expect(sut.collectionView.contentInset.top).to(equal(0))
                    expect(sut.collectionView.contentInset.bottom).to(equal(0))
                    expect(sut.collectionView.contentInset.left).to(equal(20))
                    expect(sut.collectionView.contentInset.right).to(equal(20))
                    expect(sut.collectionView.showsVerticalScrollIndicator).to(beFalse())
                    expect(sut.collectionView.showsHorizontalScrollIndicator).to(beFalse())
                    expect(sut.collectionView.superview).to(equal(sut.view))
                    expect(sut.collectionView.delegate).toNot(beNil())
                }

                it("should call didFinishViewDidLoad from presenter") {
                    expect(presenterMock.isDidFinishViewDidLoadCalled).to(beTrue())
                }
            }

            context("when sizeForItemAt is called") {
                it("should return properly size") {
                    sut.collectionView.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
                    let size = sut.collectionView(sut.collectionView, layout:
                        sut.collectionView.collectionViewLayout,
                        sizeForItemAt: IndexPath(row: 0, section: 0))
                    expect(size.width).to(equal(270))
                    expect(size.height).to(equal(340))
                }
            }

            context("when setWeatherList is called") {
                beforeEach {
                    sut.setWeatherList(weatherList: [WeatherOptions.mock()])
                }

                it("should configure dataSource") {
                    expect(sut.dataSource).toNot(beNil())
                    expect(sut.collectionView.dataSource).toNot(beNil())
                }
            }
        }
    }
}
