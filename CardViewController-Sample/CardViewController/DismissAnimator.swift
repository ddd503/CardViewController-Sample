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

    init(duration: TimeInterval) {
        self.duration = duration
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

        let animation = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.8) {
            contentVC.view.frame.origin.y = UIScreen.main.bounds.height
            fromVC.view.alpha = 0
        }
        animation.addCompletion { (_) in
            let isCompleteTransition = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(isCompleteTransition)
        }
        animation.startAnimation()
    }
}
