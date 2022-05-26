// 
//  SeparatorRowView.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

// MARK: - Class

final class SeparatorRowView: ReusableNibView {

    struct Model {
        let height: CGFloat
    }

    // MARK: - Outlet
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!

    // MARK: - Variable
    
    private var model: Model?

    // MARK: - Setup

    func setup(_ model: Model) {
        self.model = model
        
        heightConstraint.constant = model.height
    }
    
    var height: CGFloat? {
        return model?.height
    }

}
