import UIKit

protocol CurrentWeatherViewPresenter: LifeCyclePresenter {
    var currentWeatherViewController: CurrentWeatherViewController? { get set }

    func didTouchSeeNearbyWeathers()
}

class CurrentWeatherViewController: DesafioCIANDTViewController, CodableView {
    let labelUserName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)

        return label
    }()

    var viewWeather = WeatherView()

    lazy var buttonWeatherList: ChallangeButton = {
        let button = ChallangeButton(title: "See nearby cities")
        button.addTarget(self, action: #selector(seeNearbyWeather), for: .touchUpInside)

        return button
    }()

    var presenter: CurrentWeatherViewPresenter?

    init(presenter: CurrentWeatherViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter?.currentWeatherViewController = self
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.didFinishViewDidLoad()
    }

    func configureViews() {
        view.backgroundColor = UIColor.lightGray
    }

    func buildViewHierarchy() {
        view.addSubview(labelUserName)
        view.addSubview(viewWeather)
        view.addSubview(buttonWeatherList)
    }

    func buildConstraints() {
        labelUserName.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
            }

            make.leading.equalToSuperview().offset(20)
        }

        viewWeather.snp.makeConstraints { make in
            make.top.equalTo(labelUserName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        buttonWeatherList.snp.makeConstraints { make in
            make.top.equalTo(viewWeather.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(45)
        }
    }

    func setWeatherOptions(weatherOptions: WeatherOptions) {
        viewWeather.setWeatherOptions(weatherOptions: weatherOptions)
    }

    func setUserName(name: String) {
        labelUserName.text = name
    }

    @objc func seeNearbyWeather() {
        presenter?.didTouchSeeNearbyWeathers()
    }
}
