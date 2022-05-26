// 
//  ChecklistRowView.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

// MARK: - Class

final class ChecklistRowView: ReusableNibView {

    struct Model {
        let title: String
        let isChecked: Bool
    }

    // MARK: - Outlet
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
    }

}
