//
//  ShadowView.swift
//  Checklists
//
//  Created by Otim John Paul on 26.05.22.
//

import UIKit

class ShadowView: UIView, ShadowAble {
    
    var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupShadow()
    }
    
}

    // MARK: - ShadowAble Interface

protocol ShadowAble where Self: UIView {
    
    var shadowLayer: CAShapeLayer! { get set }
    func setupShadow()
    
}

extension ShadowAble {
    
    func setupShadow() {
        if let shadowLayer = self.shadowLayer {
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            shadowLayer.shadowPath = shadowLayer.path
        } else {
            shadowLayer = CAShapeLayer()
            shadowLayer.shouldRasterize = true
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 1, height: 1)
            shadowLayer.shadowOpacity = 0.1
            shadowLayer.shadowRadius = 10
            
            layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
}
