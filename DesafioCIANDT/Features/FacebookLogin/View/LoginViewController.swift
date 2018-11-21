import FBSDKCoreKit
import FBSDKLoginKit
import UIKit

protocol LoginViewPresenter: LifeCyclePresenter {
    var loginViewController: LoginViewController? { get set }

    func didCompleteFacebookLogin()
}

class LoginViewController: DesafioCIANDTViewController, CodableView {
    lazy var buttonFacebook: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.delegate = self
        button.readPermissions = ["public_profile"]

        return button
    }()

    var presenter: LoginViewPresenter?

    init(presenter: LoginViewPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        self.presenter?.loginViewController = self
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
        view.backgroundColor = UIColor.white
    }

    func buildViewHierarchy() {
        view.addSubview(buttonFacebook)
    }

    func buildConstraints() {
        buttonFacebook.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(45)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}

extension LoginViewController: FBSDKLoginButtonDelegate {
    func loginButtonDidLogOut(_: FBSDKLoginButton!) {}

    func loginButton(_: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error _: Error!) {
        presenter?.didCompleteFacebookLogin()
    }
}
