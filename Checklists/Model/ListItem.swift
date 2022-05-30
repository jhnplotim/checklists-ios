//
//  ListItem.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class ListItem: NSObject, Codable {
    
    enum State: Equatable {
        case noItems
        case allItemsDone
        case itemsRemaining(_ remaining: Int)
        
        var message: String {
            switch self {
            case .noItems:
                return L.Feature.Checklist.State.Noitems.label
                
            case .allItemsDone:
                return L.Feature.Checklist.State.Allitemsdone.label
                
            case .itemsRemaining(let remaining):
                return L.Feature.Checklist.State.Itemsremaining.label(remaining)
            }
        }
    }
    
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

extension ListItem {
    var state: State {
        if checkListItems.isEmpty {
            return .noItems
        } else {
            let isNotCheckedCount = checkListItems.filter {!$0.isChecked}.count
            if isNotCheckedCount == 0 {
                return .allItemsDone
            } else {
                return .itemsRemaining(isNotCheckedCount)
            }
        }
    }
}
