import Reusable
import UIKit

class WeatherCell: UICollectionViewCell, CodableView, Reusable {
    let viewWeather = WeatherView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViews() {
        backgroundColor = UIColor.lightGray
    }

    func buildViewHierarchy() {
        addSubview(viewWeather)
    }

    func buildConstraints() {
        viewWeather.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-20)
        }
    }

    func setWeatherOptions(weatherOptions: WeatherOptions) {
        viewWeather.setWeatherOptions(weatherOptions: weatherOptions)
    }
}
