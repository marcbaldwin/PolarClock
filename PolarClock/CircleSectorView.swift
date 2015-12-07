import UIKit

class CircleSectorView: UIView {

    private let depth: CGFloat
    private let startAngle: CGFloat
    private let endAngle: CGFloat

    private lazy var segmentLayer = CAShapeLayer()

    override init(frame: CGRect) {
        startAngle = -CGFloat(90).toRadians()
        endAngle = CGFloat(135).toRadians()
        depth = CGFloat(10)
        super.init(frame: frame)
        segmentLayer.fillColor = UIColor.redColor().CGColor
        layer.addSublayer(segmentLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let radius = (frame.width / 2) - depth/2
        let arc = UIBezierPath(arcCenter: bounds.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        let strokedArc = CGPathCreateCopyByStrokingPath(arc.CGPath, nil, depth, .Butt, .Miter, 10)

        segmentLayer.path = strokedArc
    }
}