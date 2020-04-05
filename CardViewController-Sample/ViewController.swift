//
//  ViewController.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func didTap(sender: UIButton) {
        let cardVC = CardViewController(contentVC: ContentViewController(), contentPositionType: .half)
        present(cardVC, animated: true)
    }
}
