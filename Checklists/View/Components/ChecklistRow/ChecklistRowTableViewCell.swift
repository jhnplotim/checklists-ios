// 
//  ChecklistRowTableViewCell.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

// MARK: - Class

final class ChecklistRowTableViewCell: ShrinkCell {

    @IBOutlet weak var contentXib: ChecklistRowView!

    func setup(model: ChecklistRowView.Model) {
        contentXib.setup(model)
    }

}
