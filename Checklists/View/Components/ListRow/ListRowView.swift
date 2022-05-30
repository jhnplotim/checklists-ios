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
        let subTitle: String
        let iconName: String
        
        init(title: String, subTitle: String) {
            self.title = title
            self.subTitle = subTitle
            self.iconName = ""
        }
        
        init(title: String, subTitle: String, iconName: String) {
            self.title = title
            self.subTitle = subTitle
            self.iconName = iconName
        }
    }

    // MARK: - Outlet
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var subTitleLabel: Label!
    @IBOutlet weak var iconImage: UIImageView!
    
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
        subTitleLabel.text = model.subTitle
        iconImage.image = UIImage(systemName: model.iconName)
    }

}

// MARK: - Extension ListRowView.Model -> ListItem
extension ListRowView.Model {
    var listItem: ListItem {
        ListItem(title: self.title)
    }
}
