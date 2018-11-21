import UIKit

protocol NearbyWeatherViewPresenter: LifeCyclePresenter {
    var nearbyWeatherViewController: NearbyWeatherViewController? { get set }
}

class NearbyWeatherViewController: DesafioCIANDTViewController, CodableView {
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 20

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    var dataSource: WeatherDataSource?
    var presenter: NearbyWeatherViewPresenter?

    init(presenter: NearbyWeatherViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter?.nearbyWeatherViewController = self
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

        configureCollectionView()
    }

    func buildViewHierarchy() {
        view.addSubview(collectionView)
    }

    func buildConstraints() {
        collectionView.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom).offset(20)
            }

            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
    }

    func setWeatherList(weatherList: [WeatherOptions]) {
        dataSource = WeatherDataSource(weatherList: weatherList)
        collectionView.dataSource = dataSource

        collectionView.reloadData()
    }

    private func configureCollectionView() {
        collectionView.register(cellType: WeatherCell.self)

        collectionView.delegate = self
    }
}

extension NearbyWeatherViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 50, height: 340)
    }
}
