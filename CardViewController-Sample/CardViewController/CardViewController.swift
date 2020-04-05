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
    let contentPositionType: ContentPositionType
    let presentDuration: TimeInterval
    let dismissDuration: TimeInterval
    let canScrollContentView: Bool
    let shouldBounce: Bool
    let contentVCCornerRadius: CGFloat
    var interactor: TransitionInteractor?

    /// イニシャライザ
    /// - Parameters:
    ///   - contentVC: CardView内に表示するVC
    ///   - contentPositionType: CardViewの初期出現位置
    ///   - presentDuration: CardViewをアニメーション表示させる際のスピード
    ///   - dismissDuration: CardViewを閉じる際のスピード
    ///   - canScrollContentView: CardView内に表示するVC内でScrollViewを使用するか
    ///   - shouldBounce: CardView自体がバウンド属性を持つか
    ///   - contentVCCornerRadius: CardViewの角丸の角度（デフォルトは0）
    init(contentVC: UIViewController, contentPositionType: ContentPositionType,
         presentDuration: TimeInterval = 0.4, dismissDuration: TimeInterval = 0.2,
         canScrollContentView: Bool = false, shouldBounce: Bool = true,
         contentVCCornerRadius: CGFloat = 0) {
        self.contentVC = contentVC
        self.contentPositionType = contentPositionType
        self.presentDuration = presentDuration
        self.dismissDuration = dismissDuration
        self.canScrollContentView = canScrollContentView
        self.shouldBounce = shouldBounce
        self.contentVCCornerRadius = contentVCCornerRadius
        super.init(nibName: "CardViewController", bundle: nil)
        transitioningDelegate = self
        modalPresentationStyle = .overCurrentContext // 下のVCを見せる
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func didTapBackgroundView(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true)
    }
}

extension CardViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        PresentAnimator(duration: presentDuration, destination: contentPositionType,
                        canScrollContentView: canScrollContentView, shouldBounce: shouldBounce,
                        cornerRadius: contentVCCornerRadius)
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        DismissAnimator(duration: dismissDuration, shouldBounce: shouldBounce)
    }

    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        // インタラクション中はインスタンスは保持する必要がある
        // contentView内でScrollViewを使用する場合はジェスチャーの衝突を防ぐため画面遷移自体のインタラクションは無効にしておく
        interactor = canScrollContentView ? nil : TransitionInteractor(cardVCType: self,
                                                                       startPositionType: contentPositionType,
                                                                       shouldBounce: shouldBounce)
        return interactor
    }
}
