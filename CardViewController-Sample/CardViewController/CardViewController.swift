//
//  CardViewController.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/05.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

protocol CardViewControllerType {
    var contentVC: UIViewController { get }
}

class CardViewController: UIViewController, CardViewControllerType {

    let contentVC: UIViewController

    init(contentVC: UIViewController) {
        self.contentVC = contentVC
        super.init(nibName: "CardViewController", bundle: nil)
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
