//
//  TableViewCell.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/06.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak private var title: UILabel!

    static var identifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    func setInfo(text: String) {
        title.text = text
    }
}
