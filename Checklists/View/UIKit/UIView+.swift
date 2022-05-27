//
//  UIView+.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

extension UIView {
    
        /// Load Self from Nib
    static func loadFromNib() -> Self {
        return loadNib(self)
    }
    
        // swiftlint:disable force_cast
    
        /// Return Instance of class with User Interface File included.
        /// - Returns: Self with with attached Nib
    static func loadNib<A>(_ owner: AnyObject, bundle: Bundle = Bundle.main) -> A {
        guard let nibName = NSStringFromClass(classForCoder()).components(separatedBy: ".").last else {
            fatalError("Class name [\(NSStringFromClass(classForCoder()))] has no components.")
        }
        
        guard let nib = bundle.loadNibNamed(nibName, owner: owner, options: nil) else {
            fatalError("Nib with name [\(nibName)] doesn't exists.")
        }
        for item in nib {
            if let item = item as? A {
                return item
            }
        }
        return nib.last as! A // Force cast for reason. If item in nib has not exact name as class, app will crash.
    }
    
}

extension UIView {
    
        /// Add Nib Content at top of view
    public func pinNibContent() {
        let content = getUINib().instantiate(withOwner: self, options: nil)
        guard let view = content.first as? UIView else {
            assert(false, "Unable to load nib content")
            return
        }
        pinSubview(view)
    }
    
        /// Get Interface builder file
        /// - Returns: Object containing Nib files
    private func getUINib() -> UINib {
        let nibName = String(describing: type(of: self))
        return UINib(nibName: nibName, bundle: nil)
    }
    
        /// Insert subview if index provided, or add at top of subviews
        /// - Parameters:
        ///   - subview: View which being inserted as subview
        ///   - index: Optional index in View hierarchy
    private func pinSubview(_ subview: UIView, at index: Int? = nil) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        if let index = index {
            insertSubview(subview, at: index)
        } else {
            addSubview(subview)
        }
        
        let views = ["v": subview]
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[v]|", metrics: nil, views: views)
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[v]|", metrics: nil, views: views)
        NSLayoutConstraint.activate(vertical + horizontal)
    }
    
        /// Insert subview at top view with specific padding
        /// - Parameters:
        ///   - subview: View which being inserted as subview
        ///   - padding: Left Right Top Bottom padding
    public func insertSubviews(_ subview: UIView, padding: CGFloat = 0.0) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        subview.topAnchor.constraint(equalTo: self.topAnchor, constant: padding).isActive = true
        subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
    }
    
}

extension UIView {
    
        /// View corner radius. Don't forget to set clipsToBounds = true
    @IBInspectable public var cornerRadiusValue: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            layer.cornerRadius = newValue
        }
    }
    
        /// View border color
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.black.cgColor)
        } set {
            layer.borderColor = newValue.cgColor
        }
    }
    
        /// View border width
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        } set {
            layer.borderWidth = newValue
        }
    }
    
        /// View's layer masks to bounds
    @IBInspectable public var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        } set {
            layer.masksToBounds = newValue
        }
    }
    
        /// View shadow opacity
    @IBInspectable public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        } set {
            layer.shadowOpacity = newValue
        }
    }
    
        /// View shadow color
    @IBInspectable public var shadowColor: UIColor {
        get {
            return UIColor(cgColor: layer.shadowColor ?? UIColor.black.cgColor)
        } set {
            layer.shadowColor = newValue.cgColor
        }
    }
    
        /// View shadow radius
    @IBInspectable public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        } set {
            layer.shadowRadius = newValue
        }
    }
    
        /// View shadow offset
    @IBInspectable public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        } set {
            layer.shadowOffset = newValue
        }
    }
    
        /// Animates shake with view
    public func shakeView(duration: CFTimeInterval = 0.02, repeatCount: Float = 8.0, offset: CGFloat = 5.0) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - offset, y: center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + offset, y: center.y))
        layer.add(animation, forKey: "position")
    }
    
    public enum Rotate {
        
        case by0, by90, by180, by270
        
        var rotationValue: Double {
            switch self {
            case .by0:
                return 0.0
                
            case .by90:
                return .pi / 2
                
            case .by180:
                return .pi
                
            case .by270:
                return .pi + .pi / 2
            }
        }
    }
    
        /// Rotates the view by specified angle.
    public func rotate(_ rotateBy: Rotate) {
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .beginFromCurrentState, animations: { [weak self] in
            self?.transform = CGAffineTransform(rotationAngle: CGFloat(rotateBy.rotationValue))
        }, completion: nil)
    }
    
}
