//
//  Instantiable+.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

public protocol NameDescribable {
    
    var typeName: String { get }
    static var typeName: String { get }
    
}

extension NameDescribable {
    
    public var typeName: String {
        return String(describing: type(of: self))
    }
    
    static public var typeName: String {
        return String(describing: self)
    }
    
}

    /// Inject NSObject with typeName
extension NSObject: NameDescribable {}

    /// Inject Array with typeName
extension Array: NameDescribable {}

public protocol Instantiable {
    static func makeInstance(name: String?) -> Self
}

extension Instantiable where Self: UIViewController {
    
        /// Instantiates controller from storyboard.
        /// - example:
        /// `let myViewController = MyViewController.makeInstance()`
        /// - important:
        /// Initial controller of the same type must exists in storyboard named as controller's
        /// class without "ViewController" suffix, otherwise will `fatalError()`.
        /// - Returns: Instantiated view controller.
    static public func makeInstance(name: String? = nil) -> Self {
        var viewControllerName: String
        if let name = name {
            viewControllerName = name
        } else {
            viewControllerName = typeName
        }
        
        let storyboard = UIStoryboard(name: viewControllerName, bundle: nil)
        guard let instance =
                storyboard.instantiateInitialViewController() as? Self
                ??
                storyboard.instantiateViewController(identifier: viewControllerName) as? Self
                
        else { fatalError("Could not make instance of \(String(describing: self))") }
        return instance
    }
    
}

extension UIViewController: Instantiable {}
