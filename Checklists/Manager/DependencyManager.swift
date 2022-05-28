//
//  DependencyManager.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class DependencyContainer: WithStorageManager {
    // Singleton
    lazy var storageManager: StorageManager = StorageManagerImpl(di: self)
}

let di = DependencyContainer()
