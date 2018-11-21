import MBProgressHUD
import UIKit

typealias SelectedBlock = (Int) -> Void

class DesafioCIANDTViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        hideNavigationItemBackTitle()
    }

    func showLoading() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }

    func hideLoading() {
        MBProgressHUD.hide(for: view, animated: true)
    }

    func pushViewController(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }

    func popViewController() {
        navigationController?.popViewController(animated: true)
    }

    func hideNavigationItemBackTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func showAlert(with title: String, message: String, options: [String], selected: SelectedBlock?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        for index in 0 ..< options.count {
            let action = UIAlertAction(title: options[index], style: .default) { [weak self] _ in
                if let block = selected {
                    block(index)
                } else {
                    self?.dismiss(animated: true, completion: nil)
                }
            }

            alert.addAction(action)
        }

        present(alert, animated: true, completion: nil)
    }

    func showError(message: String) {
        showAlert(with: "Error", message: message, options: ["OK"], selected: nil)
    }
}
