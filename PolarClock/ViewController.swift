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
                let targetEndAngle = CGFloat(Int.random(0...360))
                self.polarClockView.animateRingAtIndex(index, endAngle: targetEndAngle, duration: self.maxDuration)
                
            }
        }
    }
}