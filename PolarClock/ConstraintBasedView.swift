import UIKit

class ConstraintBasedView: UIView {
    
    var hasInitConstraints = false

    init() {
        super.init(frame: CGRectZero)
        initViewIfRequired()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initViewIfRequired()
    }
}

extension ConstraintBasedView { // MARK: Public

    func initViewInInit() -> Bool {
        return true
    }

    func initView() {
        addSubviews(initialSubviews())
        disableTranslatesAutoresizingMaskIntoConstraints()
        setNeedsUpdateConstraints()
    }

    func initConstraints() { }

    func initialSubviews() -> [UIView] { return [UIView]() }
}

extension ConstraintBasedView { // MARK: Override

    override class func requiresConstraintBasedLayout() -> Bool { return true }

    override func updateConstraints() {
        if !hasInitConstraints {
            hasInitConstraints = true
            initConstraints()
        }
        super.updateConstraints()
    }
}

private extension ConstraintBasedView {

    private func initViewIfRequired() {
        if initViewInInit() {
            initView()
        }
    }
}