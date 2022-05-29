//
//  ListItem.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class ListItem: NSObject, Codable {
    var title: String
    
    var checkListItems: [ChecklistItem]
    
    convenience init(title: String) {
        self.init(title: title, checkListItems: [])
    }
    
    init(title: String, checkListItems: [ChecklistItem]) {
        self.title = title
        self.checkListItems = checkListItems
        super.init()
        // Any other code can go here
    }
}

// MARK: - Extension ListItem -> ListRowView.Model
extension ListItem {
    var modelListItem: ListRowView.Model {
        ListRowView.Model(title: self.title)
    }
}
