//
//  DismissAnimator.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import Foundation
import UIKit

final class DismissAnimator: NSObject {
    let duration: TimeInterval
    let shouldBounce: Bool

    init(duration: TimeInterval, shouldBounce: Bool) {
        self.duration = duration
        self.shouldBounce = shouldBounce
    }
}

extension DismissAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from), let contentVC = (fromVC as? CardViewControllerType)?.contentVC else {
            transitionContext.cancelInteractiveTransition()
            return
        }

        let task = {
            contentVC.view.frame.origin.y = UIScreen.main.bounds.height
            fromVC.view.alpha = 0
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

        animator.addCompletion { (_) in
            let isCompleteTransition = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isCompleteTransition)
        }
        animator.startAnimation()
    }
}
