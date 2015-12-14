import UIKit
import AutoLayoutBuilder

class ClockContainerView: ConstraintBasedView {

    lazy var polarClockView = PolarClockView()

    // MARK: Override

    override func initViewInInit() -> Bool {
        return false
    }

    override func initView() {
        super.initView()
        polarClockView.initView()
    }

    override func initialSubviews() -> [UIView] {
        return [polarClockView]
    }

    override func initConstraints() {
        let layout = Layout()
        layout += polarClockView[.Center] == self[.Center]
        layout += polarClockView[.Width] <= self[.Width]
        layout += polarClockView[.Height] <= self[.Height]
        let widthConstraints = polarClockView[.Width] == self[.Width]
        let heightConstraints = polarClockView[.Height] == self[.Height]
        widthConstraints.forEach { $0.priority = 750 }
        heightConstraints.forEach { $0.priority = 750 }
        layout += widthConstraints
        layout += heightConstraints
        layout += polarClockView[.AspectRatio] == 1
        layout.activateConstraints(true)
    }
}