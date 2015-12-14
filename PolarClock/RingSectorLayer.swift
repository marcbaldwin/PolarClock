import UIKit

class RingSectorLayer: CALayer {

    dynamic var startAngle = CGFloat(0)
    dynamic var endAngle = CGFloat(0)
    dynamic var depth = CGFloat(0)
    var color = UIColor.blackColor()

    // MARK: Init

    override init() {
        super.init()
    }

    override init(layer: AnyObject) {
        guard let ringSectorLayer = layer as? RingSectorLayer else { fatalError() }
        startAngle = ringSectorLayer.startAngle
        endAngle = ringSectorLayer.endAngle
        depth = ringSectorLayer.depth
        color = ringSectorLayer.color
        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Override

    override func drawInContext(ctx: CGContext) {
        let outterRadius = bounds.width/2
        let innerRadius = outterRadius - depth
        let center = CGPoint(x: outterRadius, y: outterRadius)

        let outterRing = CGCircle(center: center, radius: outterRadius)
        let innerRing = CGCircle(center: center, radius: innerRadius)

        let adjustedStartAngle = (startAngle - 90).toRadians()
        let adjustedEndAngle = (endAngle - 90).toRadians()

        let a = outterRing.pointAtAngle(adjustedStartAngle)
        let d = innerRing.pointAtAngle(adjustedEndAngle)

        CGContextBeginPath(ctx)
        CGContextMoveToPoint(ctx, a.x, a.y)
        CGContextAddArc(ctx, center.x, center.y, outterRadius, adjustedStartAngle, adjustedEndAngle, 0)
        CGContextAddLineToPoint(ctx, d.x, d.y)
        CGContextAddArc(ctx, center.x, center.y, innerRadius, adjustedEndAngle, adjustedStartAngle, 1)
        CGContextClosePath(ctx)

        CGContextSetFillColorWithColor(ctx, color.CGColor)
        CGContextDrawPath(ctx, .Fill)
    }

    override class func needsDisplayForKey(key: String) -> Bool {
        return isCustomDisplayableProperty(key) || super.needsDisplayForKey(key)
    }
}

private extension RingSectorLayer {

    class func isCustomDisplayableProperty(key: String) -> Bool {
        return key == "startAngle" || key == "endAngle" || key == "depth"
    }
}