import UIKit

extension UIView {

    convenience init(color: UIColor) {
        self.init()
        backgroundColor = color
    }

    func disableTranslatesAutoresizingMaskIntoConstraints() {
        subviews.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }

    func addSubviews(views: UIView...) {
        views.forEach { self.addSubview($0) }
    }

    func addSubviews(views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}

extension UIFont {

    func sizeOfString (string: String, constrainedToWidth width: CGFloat) -> CGSize {
        return NSString(string: string).boundingRectWithSize(CGSize(width: width, height: CGFloat.max),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
}

extension UIDynamicBehavior {

    func add(item: UIDynamicItem) {
        if let behaviour = self as? UICollisionBehavior {
            behaviour.addItem(item)
        }
        else if let behaviour = self as? UIDynamicItemBehavior {
            behaviour.addItem(item)
        }
        else if let behaviour = self as? UIGravityBehavior {
            behaviour.addItem(item)
        }
    }

    func remove(item: UIDynamicItem) {
        if let behaviour = self as? UICollisionBehavior {
            behaviour.removeItem(item)
        }
        else if let behaviour = self as? UIDynamicItemBehavior {
            behaviour.removeItem(item)
        }
        else if let behaviour = self as? UIGravityBehavior {
            behaviour.removeItem(item)
        }
    }
}

enum PresentationDirection {
    case Presenting
    case Dismissing
}