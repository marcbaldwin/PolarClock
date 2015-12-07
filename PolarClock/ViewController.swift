import UIKit

class ViewController: UIViewController {

    override func loadView() {
        view = UIView()
        view.backgroundColor = .whiteColor()

        let sector = CircleSectorView(frame: CGRect(x: 100, y: 100, width: 50, height: 50))
        view.addSubview(sector)
    }
}