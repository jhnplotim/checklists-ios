// 
//  StorageManager.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

// MARK: - Manager Type Definition

protocol StorageManager: AnyObject {
    func save()
    func load() -> [ListItem]
    func update(items: [ListItem])
    func getItem(at position: Int) -> ListItem?
}

// MARK: Manager Implementation

protocol WithStorageManager: AnyObject {

    var storageManager: StorageManager { get }

}
