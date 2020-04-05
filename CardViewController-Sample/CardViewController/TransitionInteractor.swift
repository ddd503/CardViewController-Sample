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
    var interactionInProgress = false

    init(cardVCType: CardViewControllerType) {
        self.cardVCType = cardVCType
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
        case .began:
            interactionInProgress = true
        case .changed:
            cardVCType.contentVC.view.transform = CGAffineTransform(translationX: 0, y: translation.y)
        case .cancelled:
            interactionInProgress = false
        case .ended:
            interactionInProgress = false

            let shouldCloseCardVC = cardVCType.contentVC.view.frame.origin.y > UIScreen.main.bounds.height * 0.7
            let animator: UIViewPropertyAnimator

            if shouldCloseCardVC {
                animator = UIViewPropertyAnimator(duration: Double(duration / 3), curve: .easeIn, animations: { [weak self] in
                    self?.cardVCType.contentVC.view.frame.origin.y = UIScreen.main.bounds.height
                })
            } else {
                animator = UIViewPropertyAnimator(duration: Double(duration), dampingRatio: 0.8) { [weak self] in
                    self?.cardVCType.contentVC.view.transform = .identity
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
