//
//  BaseTableViewController.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit


class BaseUITableViewController: UITableViewController {
    
    let generator = UIImpactFeedbackGenerator(style: .medium)
    
    override func viewDidLoad() {
        view.backgroundColor = Asset.white.color
        tableView.backgroundColor = Asset.white.color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
