import UIKit
import AutoLayoutBuilder
import Async

class ViewController: UIViewController {

    lazy var polarClockView = PolarClockView()
    private let maxDuration: Double = 0.75

    override func loadView() {
        view = UIView()
        view.backgroundColor = .whiteColor()
        polarClockView.dataSource = self
        polarClockView.initView()
        polarClockView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(polarClockView)

        let layout = Layout()
        layout += polarClockView[.Center] == view[.Center]
        layout += polarClockView[.Width] == view[.Width] - 40
        layout += polarClockView[.AspectRatio] == 1
        layout.activateConstraints(true)
    }

    override func viewDidAppear(animated: Bool) {
        doInitialAnimation()
    }
}

extension ViewController: PolarClockViewDataSource {

    func sectorCount() -> Int {
        return 5
    }
}

private extension ViewController {

    func doInitialAnimation() {

        for index in 0 ..< sectorCount() {
            Async.main(after: maxDuration * 0.3 * Double(index)) {
                let ringSectorView = self.polarClockView.ringAtIndex(index)
                let targetEndAngle = CGFloat(Int.random(0...360))

                let endAngleAnimation = ringSectorView.animateEndAngle(targetEndAngle)
                endAngleAnimation.duration = self.maxDuration
                endAngleAnimation.fillMode = kCAFillModeForwards

                let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
                fadeInAnimation.fromValue = 0
                fadeInAnimation.toValue = 1
                fadeInAnimation.duration = self.maxDuration
                fadeInAnimation.fillMode = kCAFillModeForwards

                let animationGroup = CAAnimationGroup()
                animationGroup.animations = [endAngleAnimation, fadeInAnimation]
                animationGroup.duration = self.maxDuration
                animationGroup.fillMode = kCAFillModeForwards
                animationGroup.removedOnCompletion = false

                CATransaction.begin()
                CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
                CATransaction.setCompletionBlock { () -> Void in
                    ringSectorView.endAngle = targetEndAngle
                    ringSectorView.layer.opacity = 1
                }

                ringSectorView.layer.addAnimation(animationGroup, forKey: "initialAnimation")
                CATransaction.commit()
            }
        }
    }
}