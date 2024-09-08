import SpriteKit
import UIKit

extension NSLayoutAnchor {
    
    @objc func constraint(equalTo: NSLayoutAnchor<AnchorType>, constant: CGFloat = 0, priority: UILayoutPriority) -> NSLayoutConstraint {
        let layoutConstraint = constraint(equalTo: equalTo, constant: constant)
        layoutConstraint.priority = priority
        return layoutConstraint
    }
    
}

extension NSLayoutConstraint {
    
    func settingPriority(to priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
    
}

extension SKSpriteNode {

    func aspectFill(size: CGSize) {
        guard let texture else { return }
        self.size = texture.size()
        let horizontalRatio = size.width /  texture.size().width
        let verticalRatio = size.height / texture.size().height
        let scaleRatio = max(horizontalRatio, verticalRatio)
        setScale(scaleRatio)
    }

}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
    
}

extension UIView {
    
    var heightConstraint: NSLayoutConstraint? {
        get { constraints.first { $0.firstAttribute == .height } }
        set { setNeedsLayout() }
    }

    var widthConstraint: NSLayoutConstraint? {
        get { constraints.first { $0.firstAttribute == .width } }
        set { setNeedsLayout() }
    }
    
    func layout(in view: UIView?, at position: Int? = nil, _ constraints: [NSLayoutConstraint]) {
        translatesAutoresizingMaskIntoConstraints = false
        if let view, let position {
            view.insertSubview(self, at: position)
        } else if let view {
            view.addSubview(self)
        }
        NSLayoutConstraint.activate(constraints)
    }
    
}
