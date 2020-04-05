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

    init(duration: TimeInterval, destination: ContentPositionType, shouldBounce: Bool) {
        self.duration = duration
        self.destination = destination
        self.shouldBounce = shouldBounce
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

        contentVC.view.frame = CGRect(x: finalFrame.origin.x,
                                      y: UIScreen.main.bounds.height,
                                      width: finalFrame.size.width,
                                      height: finalFrame.size.height)
        containerView.addSubview(toVC.view)
        containerView.addSubview(contentVC.view)

        let task = { [unowned self] in
            contentVC.view.frame = CGRect(x: finalFrame.origin.x,
                                          y: self.destination.originY,
                                          width: finalFrame.size.width,
                                          height: finalFrame.size.height)
        }

        let animation: UIViewPropertyAnimator

        if shouldBounce {
            animation = UIViewPropertyAnimator(duration: duration, dampingRatio: 0.7) {
                task()
            }
        } else {
            animation = UIViewPropertyAnimator(duration: duration, curve: .easeIn, animations: {
                task()
            })
        }

        animation.startAnimation()

        transitionContext.completeTransition(true)
    }
}
