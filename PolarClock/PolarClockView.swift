import UIKit
import AutoLayoutBuilder

protocol PolarClockViewDataSource {
    func sectorCount() -> Int
    func viewAtIndex(index: Int) -> RingSectorView
}

class PolarClockView: ConstraintBasedView {

    var dataSource: PolarClockViewDataSource!

    private var sectorCount: Int { return dataSource.sectorCount() }
    private var sectors = [RingSectorView]()

    // MARK: Override

    override func initView() {
        for index in 0 ..< sectorCount {
            sectors.append(dataSource.viewAtIndex(index))
        }
        super.initView()
    }

    override func initialSubviews() -> [UIView] {
        return sectors
    }

    override func initConstraints() {
        let layout = Layout()

        for (index, circleSectorView) in sectors.enumerate() {
            layout += circleSectorView[.Width] == self[.Width] * (CGFloat(index+2) / CGFloat(sectorCount+1))
            layout += circleSectorView[.AspectRatio] == 1
        }

        layout += Group(sectors)[.Center] == self[.Center]

        layout.activateConstraints(true)
    }

    override func initViewInInit() -> Bool {
        return false
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let depth = (bounds.width / 2) / CGFloat(sectorCount + 1)
        for circleSectorView in sectors {
            circleSectorView.depth = depth - 5
        }
    }
}

extension PolarClockView {

    func ringAtIndex(index: Int) -> RingSectorView {
        return sectors[index]
    }
}