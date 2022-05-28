//
//  ListItem.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

class ListItem: NSObject, Codable {
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
