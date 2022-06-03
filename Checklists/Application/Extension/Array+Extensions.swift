//
//  Array+Extensions.swift
//  Checklists
//
//  Created by John Paul Otim on 03.06.22.
//

import Foundation

/// Couple of convenience arry extensions
extension Array {
    
    /// Check if array has valid object at index
    ///
    /// - Parameter index: Index you want to check for
    /// - Returns: True if there is a valid object
    func valid(index: Int) -> Bool {
        if index < 0 || index > self.count - 1 || self.isEmpty {
            return false
        }
        return true
    }
    
    /// Safely access array at index
    ///
    /// - Parameter index: Index you want to retrieve the element from
    /// - Returns: The element if the index is valid
    func safeGet(at index: Int) -> Element? {
        guard valid(index: index) else {
            return nil
        }
        return self[index]
    }
}
