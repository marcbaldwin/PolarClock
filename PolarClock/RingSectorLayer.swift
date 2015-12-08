import UIKit

class RingSectorLayer: CALayer {

    @NSManaged var startAngle: CGFloat
    @NSManaged var endAngle: CGFloat
    @NSManaged var depth: CGFloat

    override init() {
        super.init()
        startAngle = 0
        endAngle = 0
        depth = 0
    }

    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let ringSectorLayer = layer as? RingSectorLayer {
            startAngle = ringSectorLayer.startAngle
            endAngle = ringSectorLayer.endAngle
            depth = ringSectorLayer.depth
        } else {
            startAngle = 0
            endAngle = 0
            depth = 0
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override class func needsDisplayForKey(key: String) -> Bool {
        return isKeyAnimateable(key) || super.needsDisplayForKey(key)
    }

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

        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextDrawPath(ctx, .Fill)
    }
}

private extension RingSectorLayer {

    class func isKeyAnimateable(key: String) -> Bool {
        return key == "startAngle" || key == "endAngle" || key == "depth"
    }
}