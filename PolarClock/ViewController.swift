import UIKit
import AutoLayoutBuilder
import Async

class ViewController: UIViewController {

    struct Binding {
        let index: Int
        let color: UIColor
        let duration: () -> Int
        let value: () -> Double
    }

    lazy var clock = Clock()
    lazy var clockContainerView = ClockContainerView()
    lazy var bindings: [Binding] = self.createBindings()

    let duration: Double = 0.75
    let delay: Double = 0.3

    override func loadView() {
        view = UIView()
        view.backgroundColor = .background()
        clockContainerView.polarClockView.dataSource = self
        clockContainerView.initView()
        clockContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clockContainerView)

        let layout = Layout()
        layout += clockContainerView[.Left] == view[.Left] + 20
        layout += clockContainerView[.Right] == view[.Right] - 20
        layout += clockContainerView[.Top] == layoutGuides.top[.Bottom] + 20
        layout += clockContainerView[.Bottom] == view[.Bottom] - 20
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

    func animateInitialDisplay() {
        for binding in bindings {
            Async.main(after: duration * delay * Double(binding.index)) {
                self.animateInitialDisplayOfBinding(binding)
            }
        }
    }

    func animateInitialDisplayOfBinding(binding: Binding) {
        let view = clockContainerView.polarClockView.ringAtIndex(binding.index)
        let targetEndAngle = CGFloat(binding.value() * 360)

        let endAngleAnimation = view.animateEndAngleFrom(0, to: targetEndAngle)
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
        CATransaction.setCompletionBlock { _ in
            view.endAngle = targetEndAngle
            view.layer.opacity = 1
            view.layer.removeAllAnimations()
            self.animateBinding(binding, withView: view)
        }

        view.layer.addAnimation(animationGroup, forKey: "initialAnimation")
        CATransaction.commit()
    }

    func animateBinding(binding: Binding, withView view: RingSectorView) {

        let duration = Double(1 - binding.value()) * Double(binding.duration())

        let endAngleAnimation = view.animateEndAngleFrom(view.endAngle, to: 360)
        endAngleAnimation.duration = duration
        endAngleAnimation.fillMode = kCAFillModeForwards

        CATransaction.begin()
        CATransaction.setCompletionBlock { _ in
            view.endAngle = 0
            view.layer.opacity = 1
            view.layer.removeAllAnimations()
            self.animateBinding(binding, withView: view)
        }
        view.layer.addAnimation(endAngleAnimation, forKey: "continuous")
        CATransaction.commit()
    }

    func createBindings() -> [Binding] {
        return [
            Binding(index: 0, color: .softBlue(), duration: { 1.seconds() }, value: { self.clock.secondProgress }),
            Binding(index: 1, color: .softCyan(), duration: { 60.seconds() }, value: { self.clock.minuteProgress }),
            Binding(index: 2, color: .limeGreen(), duration: { 60.minutesToSeconds() }, value: { self.clock.hourProgress }),
            Binding(index: 3, color: .softMagneta(), duration: { 24.hoursToSeconds() }, value: { self.clock.dayProgress }),
            Binding(index: 4, color: .softRed(), duration: { self.clock.daysInMonth.daysToSeconds() }, value:  { self.clock.monthProgress }),
            Binding(index: 5, color: .softYellowGreen(), duration: { self.clock.daysInYear.daysToSeconds() }, value: { self.clock.yearProgress }),
        ]
    }
}