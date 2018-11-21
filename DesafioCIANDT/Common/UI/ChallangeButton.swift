import UIKit

class ChallangeButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        configureView(title)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureView(_ title: String) {
        setTitle(title, for: .normal)
        backgroundColor = UIColor(red: 103 / 255, green: 168 / 255, blue: 205 / 255, alpha: 1.0)

        layer.cornerRadius = 5
    }
}
