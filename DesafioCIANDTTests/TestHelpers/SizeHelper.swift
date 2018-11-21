import UIKit

class SizeHelper {
    class func size(for view: UIView) -> CGSize {
        let size = CGSize(width: 320, height: 0)
        let newSize = view.systemLayoutSizeFitting(size,
                                                   withHorizontalFittingPriority: UILayoutPriority.fittingSizeLevel,
                                                   verticalFittingPriority: UILayoutPriority.fittingSizeLevel)

        return newSize
    }
}
