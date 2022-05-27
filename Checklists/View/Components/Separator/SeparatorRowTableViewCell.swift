// 
//  SeparatorRowTableViewCell.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

// MARK: - Class

final class SeparatorRowTableViewCell: UITableViewCell {

    @IBOutlet weak var contentXib: SeparatorRowView!

    func setup(model: SeparatorRowView.Model) {
        contentXib.setup(model)
        
        separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
    }

}
