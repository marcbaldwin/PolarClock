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

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clearColor()
        segmentLayer.opacity = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class func layerClass() -> AnyClass {
        return RingSectorLayer.self
    }

    func animateEndAngle(endAngle: CGFloat) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "endAngle")
        animation.fromValue = segmentLayer.endAngle
        animation.toValue = endAngle
        return animation
    }
}