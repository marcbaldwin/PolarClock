import Foundation
import CoreGraphics

infix operator ** { associativity left precedence 160 }
prefix operator √ {}

extension Int {

    static func random(range: Range<Int> ) -> Int {
        var offset = 0

        if range.startIndex < 0 {
            offset = abs(range.startIndex)
        }

        let mini = UInt32(range.startIndex + offset)
        let maxi = UInt32(range.endIndex + offset)

        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}

extension Double {

    static func π() -> Double {
        return M_PI
    }
}

extension CGFloat {

    static func π() -> CGFloat {
        return CGFloat(M_PI)
    }

    func toRadians() -> CGFloat {
        return self * .π() / 180.0
    }

    func toDegrees() -> CGFloat {
        return self * 180.0 / .π()
    }
}

public func **(lhs: CGFloat, rhs: CGFloat) -> CGFloat {
    return pow(lhs, rhs)
}

public prefix func √(x: CGFloat) -> CGFloat {
    return sqrt(x)
}

extension CGPoint {

    func distanceToPoint(point: CGPoint) -> CGFloat {
        let dx = x - point.x
        let dy = y - point.y
        return sqrt(pow(dx, 2) + pow(dy, 2))
    }
}

extension CGRect {

    init(center: CGPoint, size: CGSize) {
        let x = center.x - size.width / 2
        let y = center.y - size.height / 2
        self.init(origin: CGPoint(x: x, y: y), size: size)
    }

    func greatestDistanceFromEdgeTo(point: CGPoint) -> CGFloat {
        let topLeft = point.distanceToPoint(CGPoint(x: 0, y: 0))
        let topRight = point.distanceToPoint(CGPoint(x: width, y: 0))
        let bottomLeft = point.distanceToPoint(CGPoint(x: 0, y: height))
        let bottomRight = point.distanceToPoint(CGPoint(x: width, y: height))
        return max(topLeft, topRight, bottomLeft, bottomRight)
    }

    var center: CGPoint {
        return CGPoint(x: origin.x + width/2, y: origin.y + height/2)
    }
}

// MARK: CGSize

public func +(lhs: CGSize, rhs: CGSize) -> CGSize {
    return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
}

public func -(lhs: CGSize, rhs: CGSize) -> CGSize {
    return lhs + CGSize(width: -rhs.width, height: -rhs.height)
}

public func +(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return lhs + CGSize(width: rhs, height: rhs)
}

public func -(lhs: CGSize, rhs: CGFloat) -> CGSize {
    return lhs - CGSize(width: rhs, height: rhs)
}