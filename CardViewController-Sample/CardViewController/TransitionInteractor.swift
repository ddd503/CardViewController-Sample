//
//  TransitionInteractor.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit
import Foundation

final class TransitionInteractor: UIPercentDrivenInteractiveTransition {
    
    weak var cardVCType: CardViewControllerType!
    let startPositionType: ContentPositionType
    let shouldBounce: Bool

    init(cardVCType: CardViewControllerType, startPositionType: ContentPositionType, shouldBounce: Bool) {
        self.cardVCType = cardVCType
        self.startPositionType = startPositionType
        self.shouldBounce = shouldBounce
        super.init()
        setupPanGesture()
    }

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        cardVCType.contentVC.view.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: cardVCType.contentVC.view)
        switch gesture.state {
        case .changed:
            cardVCType.contentVC.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .ended:
            let shouldCloseCardVC = cardVCType.contentVC.view.frame.origin.y > startPositionType.closeLimitOriginY
            let animator: UIViewPropertyAnimator

            if shouldCloseCardVC {
                animator = UIViewPropertyAnimator(duration: Double(duration / 3), curve: .easeIn, animations: { [weak self] in
                    self?.cardVCType.contentVC.view.frame.origin.y = UIScreen.main.bounds.height
                })
            } else {
                if shouldBounce {
                    animator = UIViewPropertyAnimator(duration: Double(duration), dampingRatio: 0.7) { [weak self] in
                        self?.cardVCType.contentVC.view.transform = .identity
                    }
                } else {
                    animator = UIViewPropertyAnimator(duration: Double(duration / 3), curve: .easeIn, animations: { [weak self] in
                        self?.cardVCType.contentVC.view.transform = .identity
                    })
                }
            }

            animator.addCompletion { [weak self] (_) in
                guard shouldCloseCardVC else {
                    self?.cancel()
                    return
                }
                self?.finish()
                self?.cardVCType.dismiss(animated: true)
            }

            animator.startAnimation()
        default: break
        }
    }

}
