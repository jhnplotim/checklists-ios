// 
//  ListRowView.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit

// MARK: - Class

final class ListRowView: ReusableNibView {

    struct Model: Codable {
        let title: String
    }

    // MARK: - Outlet
    @IBOutlet weak var titleLabel: Label!
    
    // MARK: - Variable

    private var model: Model?

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Setup

    func setup(_ model: Model) {
        self.model = model
        
        titleLabel.text = model.title
    }

}
