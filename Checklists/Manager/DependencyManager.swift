//
//  DependencyManager.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class DependencyContainer: WithStorageManager, WithCacheManager, WithNotificationManager {
    // Singleton
    lazy var storageManager: StorageManager = StorageManagerImpl.getSharedInstance(di: self)
    
    lazy var cacheManager: CacheManager = CacheManagerImpl()
    
    lazy var notificationManager: NotificationManager = NotificationManagerImpl(di: self)
}

let di = DependencyContainer()
