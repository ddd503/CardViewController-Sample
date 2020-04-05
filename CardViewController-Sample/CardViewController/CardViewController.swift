//
//  CardViewController.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

protocol CardViewControllerType: UIViewController {
    var contentVC: UIViewController { get }
}

final class CardViewController: UIViewController, CardViewControllerType {

    let contentVC: UIViewController
    var interactor: TransitionInteractor?

    init(contentVC: UIViewController) {
        self.contentVC = contentVC
        super.init(nibName: "CardViewController", bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .overCurrentContext // 下のVCを見せる
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func didTapBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}

extension CardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentAnimator(duration: 0.5, destination: .half)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimator(duration: 0.5)
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        self.interactor = TransitionInteractor(cardVCType: self)
        return self.interactor
    }
}
