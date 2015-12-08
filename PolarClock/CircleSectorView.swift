import UIKit

class CircleSectorView: UIView {

    var depth = CGFloat(0)
    var startAngle: CGFloat
    var endAngle: CGFloat

    private lazy var segmentLayer = CAShapeLayer()

    override init(frame: CGRect) {
        startAngle = CGFloat(0)
        endAngle = CGFloat(135)
        super.init(frame: frame)
        segmentLayer.fillColor = UIColor.redColor().CGColor
        layer.addSublayer(segmentLayer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updatePath()
    }
}

private extension CircleSectorView {

    func makePath() -> CGPath? {
        let radius = (bounds.width / 2) - (depth / 2)
        let startAngleRadians = (startAngle - 90).toRadians()
        let endAngleRadians = (endAngle - 90).toRadians()
        let arc = UIBezierPath(arcCenter: bounds.center, radius: radius,
            startAngle: startAngleRadians, endAngle: endAngleRadians, clockwise: true)
        return CGPathCreateCopyByStrokingPath(arc.CGPath, nil, depth, .Butt, .Miter, 10)
    }

    func updatePath() {
        segmentLayer.path = makePath()
    }
}