//
//  ReusableNibView.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

class ReusableNibView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        pinNibContent()
        awakeFromCode()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        pinNibContent()
    }
    
    func awakeFromCode() {}
    
}
