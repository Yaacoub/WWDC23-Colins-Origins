import UIKit

final class TransitionFade: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    
    // MARK: - Properties
    
    let duration: TimeInterval
    
    
    
    // MARK: - Initialization
    
    init(duration: TimeInterval) {
        self.duration = duration
    }
    
    
    
    // MARK: - UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let desinationView = transitionContext.view(forKey: .to) else { return }
        desinationView.alpha = 0
        transitionContext.containerView.addSubview(desinationView)
        UIView.animate(withDuration: duration) {
            desinationView.alpha = 1
        } completion: { finished in
            transitionContext.completeTransition(finished)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
}
