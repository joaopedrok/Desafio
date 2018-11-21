import Foundation

protocol CodableView {
    func configureViews()
    func buildViewHierarchy()
    func buildConstraints()
}

extension CodableView {
    func setup() {
        configureViews()
        buildViewHierarchy()
        buildConstraints()
    }
}
