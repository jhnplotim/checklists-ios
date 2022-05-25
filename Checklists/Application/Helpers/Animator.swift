//
//  Animator.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

 /// Global animator class.
final class Animator {
        // Fade animation helper method when replaced root view controller in main Window object
        /// - Parameters:
        ///   - vc: View controller
        ///   - animated: Should use animation - true, false
        ///   - window: Main application window
    static func setRootViewController(_ vc: UIViewController, animated: Bool = true, window: UIWindow) {
        guard animated else {
            window.rootViewController = vc
            window.makeKeyAndVisible()
            
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}
