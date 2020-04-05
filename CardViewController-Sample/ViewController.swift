//
//  ViewController.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var cardVC: CardViewController!
    var interactor: TransitionInteractor!

    @IBAction func didTap(sender: UIButton) {
        cardVC = CardViewController(contentVC: ContentViewController())
        cardVC.transitioningDelegate = self
        cardVC.modalPresentationStyle = .overCurrentContext // 下のVCを見せる
        present(cardVC, animated: true)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentAnimator(duration: 0.5)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimator(duration: 0.5)
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        interactor = TransitionInteractor(cardVCType: cardVC)
        return interactor
    }
}
