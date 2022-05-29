//
//  DependencyManager.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class DependencyContainer: WithStorageManager, WithCacheManager {
    // Singleton
    lazy var storageManager: StorageManager = StorageManagerImpl.getSharedInstance(di: self)
    
    lazy var cacheManager: CacheManager = CacheManagerImpl()
}

let di = DependencyContainer()
