//
//  ListItem.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class ListItem: NSObject, Codable {
    var title: String
    
    init(title: String) {
        self.title = title
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
