import UIKit
import AutoLayoutBuilder
import Async

class ViewController: UIViewController {

    private struct Binding {
        let color: UIColor
        let value: () -> CGFloat
    }

    lazy var clock = Clock()
    lazy var polarClockView = PolarClockView()
    private lazy var bindings: [Binding] = self.createBindings()

    let duration: Double = 0.75
    let delay: Double = 0.3

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
        animateInitialDisplay()
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

    func animateInitialDisplay() {
        bindings.enumerate().forEach { index, binding in
            Async.main(after: duration * delay * Double(index)) {
                let ringSectorView = self.polarClockView.ringAtIndex(index)
                self.animateInitialDisplayOfBinding(binding, viewWith: ringSectorView)
            }
        }
        Async.main(after: duration * delay * Double(sectorCount())) {
            self.tick()
        }
    }

    func animateInitialDisplayOfBinding(binding: Binding, viewWith view: RingSectorView) {

        let targetEndAngle = binding.value() * 360

        let endAngleAnimation = view.animateEndAngle(targetEndAngle)
        endAngleAnimation.duration = duration
        endAngleAnimation.fillMode = kCAFillModeForwards

        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = duration
        fadeInAnimation.fillMode = kCAFillModeForwards

        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [endAngleAnimation, fadeInAnimation]
        animationGroup.duration = duration
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false

        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut))
        CATransaction.setCompletionBlock { () -> Void in
            view.endAngle = targetEndAngle
            view.layer.opacity = 1
        }

        view.layer.addAnimation(animationGroup, forKey: "initialAnimation")
        CATransaction.commit()
    }

    func createBindings() -> [Binding] {
        return [
            Binding(color: .softCyan(), value: { CGFloat(self.clock.yearProgress) }),
            Binding(color: .limeGreen(), value: { CGFloat(self.clock.monthProgress) }),
            Binding(color: .softMagneta(), value: { CGFloat(self.clock.dayProgress) }),
            Binding(color: .softRed(), value: { CGFloat(self.clock.hourProgress) }),
            Binding(color: .softYellowGreen(), value: { CGFloat(self.clock.minuteProgress) }),
        ]
    }
}