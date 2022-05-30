// 
//  CacheManager.swift
//  Checklists
//
//  Created by John Paul Otim on 29.05.22.
//

import Foundation
import Combine

// MARK: - Manager Type Definition

protocol CacheManager: AnyObject {
    
    // MARK: - Attributes

    var lastSelectedListIndex: Int { get set }
    
    var isFirstRun: Bool { get set }
    
    // MARK: - Publishers
    var lastSelectedListIndexPublisher: AnyPublisher<Int, Never> { get }
    
    var isFirstRunPublisher: AnyPublisher<Bool, Never> { get }
    
    func flush()

}

// MARK: Manager Implementation

protocol WithCacheManager: AnyObject {

    var cacheManager: CacheManager { get }

}
