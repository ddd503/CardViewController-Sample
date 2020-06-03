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
    let transitionDestination: ContentPositionType

    init(cardVCType: CardViewControllerType, startPositionType: ContentPositionType,
         shouldBounce: Bool, transitionDestination: ContentPositionType) {
        self.cardVCType = cardVCType
        self.startPositionType = startPositionType
        self.shouldBounce = shouldBounce
        self.transitionDestination = transitionDestination
        super.init()
        setupPanGesture()
    }

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        cardVCType.contentVC.view.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: cardVCType.contentVC.view)
        let screenSizeHegiht = UIScreen.main.bounds.height

        switch gesture.state {
        case .changed:
            cardVCType.contentVC.view.transform = CGAffineTransform(translationX: 0, y: translation.y)

            if screenSizeHegiht > cardVCType.contentVC.view.frame.height && translation.y < 0 {
                cardVCType.contentVC.view.frame.size.height -= translation.y
            }
        case .ended:
            let shouldCloseCardVC = cardVCType.contentVC.view.frame.origin.y > startPositionType.closeLimitOriginY
            let animator: UIViewPropertyAnimator

            if shouldCloseCardVC {
                animator = UIViewPropertyAnimator(duration: Double(duration / 3), curve: .easeIn, animations: { [weak self] in
                    self?.cardVCType.contentVC.view.frame.origin.y = screenSizeHegiht
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
                guard let self = self else { return }
                guard shouldCloseCardVC else {
                    self.cancel()
                    self.cardVCType.contentVC.view.frame.size.height = screenSizeHegiht - self.transitionDestination.originY
                    return
                }
                self.finish()
                self.cardVCType.dismiss(animated: true)
            }

            animator.startAnimation()
        default: break
        }
    }

}
