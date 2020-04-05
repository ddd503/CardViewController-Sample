//
//  TableContentViewController.swift
//  CardViewController-Sample
//
//  Created by kawaharadai on 2020/04/06.
//  Copyright © 2020 kawaharadai. All rights reserved.
//

import UIKit

class TableContentViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        }
    }

    var dummyDataSource = ["data1", "data2", "data3",
                           "data4", "data5", "data6",
                           "data7", "data8", "data9",
                           "data10", "data11", "data12",
                           "data13", "data14", "data15",
                           "data16", "data17", "data18",
                           "data19", "data20", "data21"]
}

extension TableContentViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyDataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        cell.setInfo(text: "Table Content: \(dummyDataSource[indexPath.row])")
        return cell
    }
}
