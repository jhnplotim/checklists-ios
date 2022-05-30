//
//  UIView+.swift
//  Checklists
//
//  Created by John Paul Otim on 30.05.22.
//

import UIKit

// MARK: - Gesture Publisher

extension UIView {
    
    func gesture(_ gestureType: GestureType = .tap(numberOfTaps: 1)) -> GesturePublisher {
        .init(view: self, gestureType: gestureType)
    }
    
}
