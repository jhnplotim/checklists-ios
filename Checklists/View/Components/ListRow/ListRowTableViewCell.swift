// 
//  ListRowTableViewCell.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit

// MARK: - Class

final class ListRowTableViewCell: UITableViewCell {

    @IBOutlet weak var contentXib: ListRowView!

    func setup(model: ListRowView.Model) {
        contentXib.setup(model)
    }

}
