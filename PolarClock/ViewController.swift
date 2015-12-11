import UIKit
import AutoLayoutBuilder
import Async

class ViewController: UIViewController {

    private struct Binding {
        let color: UIColor
        let value: () -> Double
    }

    lazy var clock = Clock()
    lazy var polarClockView = PolarClockView()
    private lazy var bindings: [Binding] = self.createBindings()

    let duration: Double = 0.75

    override func loadView() {
        view = UIView()
        view.backgroundColor = .background()
        polarClockView.dataSource = self
        polarClockView.initView()
        polarClockView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(polarClockView)

        let layout = Layout()
        layout += polarClockView[.Center] == view[.Center]
        layout += polarClockView[.Width] <= view[.Width] - 40
        layout += polarClockView[.Height] <= view[.Height] - 40
        let widthConstraints = polarClockView[.Width] == view[.Width]
        let heightConstraints = polarClockView[.Height] == view[.Height]
        widthConstraints.forEach { $0.priority = 750 }
        heightConstraints.forEach { $0.priority = 750 }
        layout += widthConstraints
        layout += heightConstraints
        layout += polarClockView[.AspectRatio] == 1
        layout.activateConstraints(true)
    }

    override func viewDidAppear(animated: Bool) {
        doInitialAnimation()
    }
}

extension ViewController: PolarClockViewDataSource {

    func sectorCount() -> Int {
        return bindings.count
    }

    func viewAtIndex(index: Int) -> RingSectorView {
        return RingSectorView(color: bindings[index].color)
    }
}

private extension ViewController {

    func tick() {
        Async.main(after: 1) {
            self.tick()
        }
    }

    func doInitialAnimation() {
        bindings.enumerate().forEach { self.animateBinding($0.element, atIndex: $0.index) }
        Async.main(after: duration * 0.3 * Double(sectorCount())) {
            self.tick()
        }
    }

    func animateBinding(binding: Binding, atIndex index: Int) {
        Async.main(after: duration * 0.3 * Double(index)) {

            let ringSectorView = self.polarClockView.ringAtIndex(index)
            let targetEndAngle = CGFloat(binding.value()) * 360

            let endAngleAnimation = ringSectorView.animateEndAngle(targetEndAngle)
            endAngleAnimation.duration = self.duration
            endAngleAnimation.fillMode = kCAFillModeForwards

            let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
            fadeInAnimation.fromValue = 0
            fadeInAnimation.toValue = 1
            fadeInAnimation.duration = self.duration
            fadeInAnimation.fillMode = kCAFillModeForwards

            let animationGroup = CAAnimationGroup()
            animationGroup.animations = [endAngleAnimation, fadeInAnimation]
            animationGroup.duration = self.duration
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

    func createBindings() -> [Binding] {
        return [
            Binding(color: .softCyan(), value: { self.clock.yearProgress }),
            Binding(color: .limeGreen(), value: { self.clock.monthProgress }),
            Binding(color: .softMagneta(), value: { self.clock.dayProgress }),
            Binding(color: .softRed(), value: { self.clock.hourProgress }),
            Binding(color: .softYellowGreen(), value: { self.clock.minuteProgress }),
        ]
    }
}