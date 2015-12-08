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

    private lazy var segmentLayer = RingSectorLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(segmentLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        segmentLayer.frame = bounds
    }

    func animateEndAngle(endAngle: CGFloat, withDuration duration: Double) {

        let animation = CABasicAnimation(keyPath: "endAngle")
        animation.fromValue = self.segmentLayer.endAngle
        animation.toValue = endAngle
        animation.duration = duration
        self.segmentLayer.addAnimation(animation, forKey: "endAngle")

        CATransaction.begin()
        CATransaction.setCompletionBlock { () -> Void in
            self.segmentLayer.endAngle = endAngle
        }
        CATransaction.commit()
    }
}