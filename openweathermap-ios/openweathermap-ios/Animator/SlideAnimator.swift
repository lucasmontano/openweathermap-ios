//
//  SlideAnimator.swift
//  openweathermap-ios
//
//  Created by Cassio Sousa on 25/04/20.
//

import UIKit

class SlideAnimator: NSObject, UIViewControllerAnimatedTransitioning {
         func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
            return 0.4
        }
        
         func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
            guard
                let toContainverView = transitionContext.viewController(forKey: .to),
                let toView = toContainverView.view else {
                return
            }
            let container = transitionContext.containerView
            transitionContext.containerView.addSubview(toView)
            toView.translatesAutoresizingMaskIntoConstraints = false
            toView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            toView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            toView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            toView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            
            container.layoutIfNeeded()
            toView.transform = CGAffineTransform(translationX: UIScreen.main.bounds.size.width, y: 0)
            
            let animationDuration = transitionDuration(using: transitionContext)
            
            // Animate the drawer sliding in and out.
            UIView.animate(withDuration: animationDuration, animations: {
                toView.transform = .identity
            }, completion: { (success) in
                transitionContext.completeTransition(success)
            })
         }
}
