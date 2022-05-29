// 
//  ChecklistRowView.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

// MARK: - Class

final class ChecklistRowView: ReusableNibView {
    
    private enum C {
        static let checkedText = "√"
        static let uncheckedText = " "
    }

    struct Model: Codable {
        let title: String
        let isChecked: Bool
    }

    // MARK: - Outlet
    @IBOutlet weak var checkBoxLabel: UILabel!
    @IBOutlet weak var titleLabel: Label!
    
    // MARK: - Variable

    private var model: Model?

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Setup

    func setup(_ model: Model) {
        self.model = model
        titleLabel.text = model.title
        checkBoxLabel.text = model.isChecked ? C.checkedText : C.uncheckedText
    }

}

// MARK: - Extension ChecklistRowView.Model -> ChecklistItem
extension ChecklistRowView.Model {
    var checklistItem: ChecklistItem {
        ChecklistItem(title: self.title, isChecked: self.isChecked)
    }
}
