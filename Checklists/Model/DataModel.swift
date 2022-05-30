//
//  File.swift
//  Checklists
//
//  Created by John Paul Otim on 30.05.22.
//

import Foundation

class DataModel {
    private var items: [ListItem]
    
    static let icons = ["bag", "cart", "banknote", "giftcard", "alarm", "eye", "pills", "heart", "brain",
                        "cross.case", "drop", "bolt", "person", "person.3", "figure.walk", "airplane.arrival", "car",
                        "airplane.departure", "tram", "ferry", "bicycle", "Scooter", "fuelpump", "gamecontroller",
                        "display", "headphones", "umbrella", "wrench", "fork.knife", "message", "phone", "envelope"]
    
    init(items: [ListItem]) {
        self.items = items
        sortChecklists()
    }
    
    convenience init() {
        self.init(items: [])
    }
    
    var isEmpty: Bool {
        return items.count == 0
    }
    
    public var count: Int {
        return items.count
    }
}

// MARK: - Public methods

extension DataModel {
    func getItems() -> [ListItem] {
        return items
    }
    
    func getItem(at position: Int) -> ListItem? {
        if isEmpty || position >= count {
            return nil
        } else {
            return items[position]
        }
    }
    
    func append(_ newElement: ListItem) {
        items.append(newElement)
        sortChecklists()
    }
    
    func append(contentsOf newElements: [ListItem]) {
        items.append(contentsOf: newElements)
        sortChecklists()
    }
    
    func remove(at index: Int) {
        items.remove(at: index)
    }
    
    func sort() {
        sortChecklists()
    }
}

// MARK: - Private Methods
extension DataModel {
    private func sortChecklists() {
        items.sort(by: { list1, list2 in
          return list1.title.localizedStandardCompare(list2.title)
                        == .orderedAscending })
      }
}
