import Kingfisher
import SnapKit
import UIKit

class WeatherView: UIView, CodableView {
    let imageViewIcon = UIImageView()

    let labelCityName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 27)
        label.textAlignment = NSTextAlignment.center
        label.text = "-"

        return label
    }()

    let labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        label.text = "-"
        label.numberOfLines = 0

        return label
    }()

    let labelTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textAlignment = NSTextAlignment.center
        label.text = "-"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let labelMinimumTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.text = "-"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let labelMaximumTemperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 25)
        label.textAlignment = NSTextAlignment.center
        label.text = "-"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true

        return label
    }()

    let labelWind: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.text = "-"

        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureViews() {
        backgroundColor = UIColor.white

        layer.cornerRadius = 5
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 10, height: 10)
    }

    func buildViewHierarchy() {
        addSubview(imageViewIcon)
        addSubview(labelCityName)
        addSubview(labelDescription)
        addSubview(labelTemperature)
        addSubview(labelMinimumTemperature)
        addSubview(labelMaximumTemperature)
        addSubview(labelWind)
    }

    func buildConstraints() {
        imageViewIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(50)
        }

        labelWind.snp.makeConstraints { make in
            make.centerY.equalTo(imageViewIcon.snp.centerY)
            make.trailing.equalToSuperview().offset(-10)
        }

        labelCityName.snp.makeConstraints { make in
            make.top.equalTo(imageViewIcon.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }

        labelDescription.snp.makeConstraints { make in
            make.top.equalTo(labelCityName.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }

        labelMinimumTemperature.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalTo(labelTemperature.snp.centerY)
            make.trailing.equalTo(labelTemperature.snp.leading).offset(-10).priority(ConstraintPriority.required)
        }

        labelTemperature.snp.makeConstraints { make in
            make.top.equalTo(labelDescription.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }

        labelMaximumTemperature.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.centerY.equalTo(labelTemperature.snp.centerY)
            make.leading.equalTo(labelTemperature.snp.trailing).offset(10).priority(ConstraintPriority.required)
        }
    }

    func setWeatherOptions(weatherOptions: WeatherOptions) {
        guard let weather = weatherOptions.weather.first else { return }

        if let url = URL(string: weather.iconURL) {
            imageViewIcon.kf.setImage(with: url)
        }

        labelCityName.text = weatherOptions.name

        let measure = Measurement(value: weatherOptions.composition.temperature, unit: UnitTemperature.celsius)
        labelTemperature.text = measure.description

        let minMeasure = Measurement(value: weatherOptions.composition.minimumTemperature, unit: Unit(symbol: "°"))
        labelMinimumTemperature.text = minMeasure.description

        let maxMeasure = Measurement(value: weatherOptions.composition.maximumTemperature, unit: Unit(symbol: "°"))
        labelMaximumTemperature.text = maxMeasure.description

        let description = weather.main + "\n" + weather.description
        labelDescription.text = description

        let windMeasure = Measurement(value: weatherOptions.wind.speed, unit: UnitSpeed.metersPerSecond)
        labelWind.text = "Wind: " + windMeasure.description
    }
}
