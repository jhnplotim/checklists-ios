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
}
