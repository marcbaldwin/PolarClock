import UIKit

class RingSectorView: UIView {

    var depth: CGFloat {
        get { return segmentLayer.depth }
        set { segmentLayer.depth = newValue }
    }
    var startAngle: CGFloat {
        get { return segmentLayer.startAngle }
        set { segmentLayer.startAngle = newValue }
    }
    var endAngle: CGFloat {
        get { return segmentLayer.endAngle }
        set { segmentLayer.endAngle = newValue }
    }

    private var segmentLayer: RingSectorLayer { return layer as! RingSectorLayer }

    // MARK: Init

    convenience init(color: UIColor) {
        self.init(frame: CGRectZero)
        segmentLayer.color = color
        segmentLayer.contentsScale = UIScreen.mainScreen().scale
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clearColor()
        segmentLayer.opacity = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Override

    override class func layerClass() -> AnyClass {
        return RingSectorLayer.self
    }

    // MARK: Public

    func animateEndAngleFrom(from: CGFloat, to: CGFloat) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "endAngle")
        animation.fromValue = from
        animation.toValue = to
        return animation
    }
}