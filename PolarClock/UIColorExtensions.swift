import UIKit

extension UIColor {

    convenience init(r:CGFloat, g:CGFloat, b:CGFloat, a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }

    convenience init(r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }

    convenience init(rgb:CGFloat) {
        self.init(r: rgb, g: rgb, b: rgb)
    }

    convenience init(blackWithAlpha alpha: CGFloat) {
        self.init(r: 0, g: 0, b: 0, a: alpha)
    }

    convenience init(whiteWithAlpha alpha: CGFloat) {
        self.init(r: 255, g: 255, b: 255, a: alpha)
    }

    convenience init(h: CGFloat, s: CGFloat, b: CGFloat) {
        self.init(hue: h/360.0, saturation: s/100.0, brightness: b/100.0, alpha: 1)
    }
}