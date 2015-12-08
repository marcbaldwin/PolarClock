import UIKit
import AutoLayoutBuilder

protocol PolarClockViewDataSource {
    func pathCount() -> Int
}

class PolarClockView: ConstraintBasedView {

    var dataSource: PolarClockViewDataSource!
    private var circleCount: Int { return dataSource.pathCount() }

    private var paths = [CircleSectorView]()

    override func initView() {
        for _ in 0 ..< circleCount {
            paths.append(CircleSectorView())
        }
        super.initView()
    }

    override func initialSubviews() -> [UIView] {
        return paths
    }

    override func initConstraints() {
        let layout = Layout()

        for (index, circleSectorView) in paths.enumerate() {
            layout += circleSectorView[.Width] == self[.Width] * (CGFloat(index+2) / CGFloat(circleCount+1))
            layout += circleSectorView[.AspectRatio] == 1
        }

        layout += Group(paths)[.Center] == self[.Center]

        layout.activateConstraints(true)
    }

    override func initViewInInit() -> Bool { return false }

    override func layoutSubviews() {
        super.layoutSubviews()
        let depth = (bounds.width / 2) / CGFloat(circleCount + 1)
        for circleSectorView in paths {
            circleSectorView.depth = depth - 5
        }
    }
}