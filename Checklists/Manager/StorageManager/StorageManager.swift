// 
//  StorageManager.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

// MARK: - Manager Type Definition

protocol StorageManager: AnyObject {
    func getCheckListItems() -> [ChecklistItem]
    func save(checkListItems items: [ChecklistItem])
}

// MARK: Manager Implementation

protocol WithStorageManager: AnyObject {

    var storageManager: StorageManager { get }

}
