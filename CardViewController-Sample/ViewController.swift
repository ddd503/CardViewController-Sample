//
//  ViewController.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func didTapNormal(sender: UIButton) {
        let cardVC = CardViewController(contentVC: ContentViewController(), contentPositionType: .half)
        present(cardVC, animated: true)
    }
    
    @IBAction func didTapTable(sender: UIButton) {
        let cardVC = CardViewController(contentVC: TableContentViewController(),
                                        contentPositionType: .upperMiddle,
                                        shouldBounce: false)
        present(cardVC, animated: true)
    }
}
