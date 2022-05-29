//
//  ChecklistItem.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var isChecked: Bool
    var title: String
    
    init(title: String, isChecked: Bool) {
        self.isChecked = isChecked
        self.title = title
        super.init()
        // Any other code can go here
    }
    
    func toggle() {
        isChecked = !isChecked
    }
}

// MARK: - Extension ChecklistItem -> ChecklistRowView.Model
extension ChecklistItem {
    var modelCheckListListItem: ChecklistRowView.Model {
        ChecklistRowView.Model(title: self.title, isChecked: self.isChecked)
    }
}
