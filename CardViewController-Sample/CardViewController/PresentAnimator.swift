//
//  PresentAnimator.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import Foundation
import UIKit

final class PresentAnimator: NSObject {
    let duration: TimeInterval
    let destination: ContentPositionType
    let shouldBounce: Bool
    let cornerRadius: CGFloat
    
    init(duration: TimeInterval, destination: ContentPositionType,
         shouldBounce: Bool, cornerRadius: CGFloat) {
        self.duration = duration
        self.destination = destination
        self.shouldBounce = shouldBounce
        self.cornerRadius = cornerRadius
    }
}

extension PresentAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
            let contentVC = (toVC as? CardViewControllerType)?.contentVC else {
                transitionContext.cancelInteractiveTransition()
                return
        }
        
        let containerView = transitionContext.containerView
        
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame
        toVC.view.layoutIfNeeded()
        containerView.addSubview(toVC.view)
        contentVC.view.frame = CGRect(x: finalFrame.origin.x,
                                      y: UIScreen.main.bounds.height,
                                      width: finalFrame.size.width,
                                      height: finalFrame.size.height)
        contentVC.view.layoutIfNeeded()
        containerView.addSubview(contentVC.view)
        
        let isRoundCorners = cornerRadius > 0
        if isRoundCorners {
            contentVC.view.layer.masksToBounds = isRoundCorners
            contentVC.view.layer.cornerRadius = cornerRadius
            contentVC.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        
        let task = { [unowned self] in
            contentVC.view.frame.origin.y = self.destination.originY
        }
        
        let animator: UIViewPropertyAnimator
        
        if shouldBounce {
            animator = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.7) {
                task()
            }
        } else {
            animator = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: {
                task()
            })
        }

        let contentVCHeightAfterAnimate = UIScreen.main.bounds.height - self.destination.originY

        animator.addCompletion {(_) in
            contentVC.view.frame.size.height = contentVCHeightAfterAnimate
        }

        animator.startAnimation()
        
        transitionContext.completeTransition(true)
    }
}
