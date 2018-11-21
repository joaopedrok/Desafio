import Reusable
import UIKit

class WeatherDataSource: NSObject, UICollectionViewDataSource {
    let weatherList: [WeatherOptions]

    init(weatherList: [WeatherOptions]) {
        self.weatherList = weatherList
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return weatherList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: WeatherCell.self)
        cell.setWeatherOptions(weatherOptions: weatherList[indexPath.row])

        return cell
    }
}
