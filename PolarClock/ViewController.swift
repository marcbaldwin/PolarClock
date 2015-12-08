import UIKit
import AutoLayoutBuilder
import Async

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

    override func viewDidAppear(animated: Bool) {
        let duration = 1.0
        for i in 0 ..< sectorCount() {
            Async.main(after:duration * Double(i)) {
                self.polarClockView.animateRingAtIndex(i, startAngle: 0, endAngle: CGFloat(35*(i+1)), duration: duration)
            }
        }

        Async.main(after: 8) {
            self.polarClockView.animateRingAtIndex(0, startAngle: 0, endAngle: 100, duration: 1)
        }
    }
}

extension ViewController: PolarClockViewDataSource {

    func sectorCount() -> Int {
        return 5
    }
}