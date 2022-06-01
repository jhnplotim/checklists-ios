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
        view.backgroundColor = Asset.appBackground.color
        tableView.backgroundColor = Asset.appBackground.color
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
}
