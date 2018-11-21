@testable import DesafioCIANDT
import Nimble
import Quick

class WeatherDataSourceSpec: QuickSpec {
    override func spec() {
        describe("WeatherDataSource") {
            var collectionView: UICollectionView!
            let weatherList = [WeatherOptions.mock(), WeatherOptions.mock()]
            var sut: WeatherDataSource!

            beforeEach {
                sut = WeatherDataSource(weatherList: weatherList)
                collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            }

            context("when its instantiated") {
                it("should set all properties") {
                    expect(sut.weatherList).toNot(beNil())
                }
            }

            context("when numberOfRowsInSection is called") {
                it("should return string array count") {
                    expect(sut.collectionView(collectionView, numberOfItemsInSection: 0)).to(equal(sut.weatherList.count))
                }
            }

            context("when cellForRow is called") {
                var cell: UICollectionViewCell!

                beforeEach {
                    collectionView.register(cellType: WeatherCell.self)
                    cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 0, section: 0))
                }

                it("should return a WeatherCell") {
                    expect(cell).to(beAKindOf(WeatherCell.self))
                }
            }
        }
    }
}
