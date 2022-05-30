//
//  ListItem.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class ListItem: NSObject, Codable {
    
    enum C {
        static let noIcon = ""
    }
    
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
    
    var iconName: String
    
    var checkListItems: [ChecklistItem]
    
    convenience init(title: String, iconName: String) {
        self.init(title: title, iconName: iconName, checkListItems: [])
    }
    
    convenience init(title: String) {
        self.init(title: title, checkListItems: [])
    }
    
    convenience init(title: String, checkListItems: [ChecklistItem]) {
        self.init(title: title, iconName: C.noIcon, checkListItems: checkListItems)
        // Any other code can go here
    }
    
    init(title: String, iconName: String, checkListItems: [ChecklistItem]) {
        self.title = title
        self.checkListItems = checkListItems
        self.iconName = iconName
        super.init()
        // Any other code can go here
    }
}

// MARK: - Extension ListItem -> ListRowView.Model
extension ListItem {
    var modelListItem: ListRowView.Model {
        ListRowView.Model(title: self.title, subTitle: self.state.message, iconName: self.iconName)
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
