// 
//  CacheManagerImpl.swift
//  Checklists
//
//  Created by John Paul Otim on 29.05.22.
//

import UIKit
import Combine
import KeychainSwift
import CombineExt

// MARK: - Manager Implementation

final class CacheManagerImpl: CacheManager {
    // MARK: - Properties
    @UserDefaultValue("lastSelectedListIndex", defaultValue: -1)
    var lastSelectedListIndex: Int
    
    // MARK: - Publishers
    lazy var lastSelectedListIndexPublisher: AnyPublisher<Int, Never> = self._lastSelectedListIndex.publisher.eraseToAnyPublisher()

}

// MARK: - Public

extension CacheManagerImpl {
    func flush() {
        lastSelectedListIndex = -1
        
        resetDefaults()
        resetKeyChainValues()
        
    }

}

// MARK: - Private

extension CacheManagerImpl {
    /// Resets all values from the UserDefaults
    private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    /// Wipe all data from the KeyChain
    private func resetKeyChainValues() {
        let keychainSwift = KeychainSwift()
        keychainSwift.clear()
    }
}
