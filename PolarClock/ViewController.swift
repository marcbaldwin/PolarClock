import UIKit
import AutoLayoutBuilder

class ViewController: UIViewController {

    lazy var polarClockView = PolarClockView()

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
}

extension ViewController: PolarClockViewDataSource {

    func pathCount() -> Int {
        return 5
    }
}