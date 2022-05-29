// 
//  StorageManagerImpl.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit

// MARK: - Manager Implementation

final class StorageManagerImpl: StorageManager {

    // MARK: - Typealias

    typealias DI = DependencyContainer

    // MARK: - Constant
    
    private enum C {
    }
    
    private enum FileType: String {
        case checklists = "Checklists.plist"
        case checklistItems = "ChecklistItems.plist"
    }

    private let di: DI

    // MARK: - Initializer

    init(di: DependencyContainer) {
        self.di = di
    }

}

// MARK: - Public

extension StorageManagerImpl {
    // TODO: Merge the get & load methods into one and use reflection to avoid code duplication
    func getCheckLists() -> [ListItem] {
        // 1a
        var items = [ListItem]()
        // 1b
        let path = dataFilePath(for: .checklists)
        // 2
        if let data = try? Data(contentsOf: path) {
          // 3
          let decoder = PropertyListDecoder()
          do {
            // 4
            items = try decoder.decode([ListItem].self,
                                       from: data)
          } catch {
            print("Error decoding item array: \(error.localizedDescription)")
          }
        }
        
        return items
    }
    
    func save(listItems items: [ListItem]) {
        // 1
        let encoder = PropertyListEncoder()
        // 2
        do {
          // 3
          let data = try encoder.encode(items)
          // 4
            try data.write(to: dataFilePath(for: .checklists),
                    options: Data.WritingOptions.atomic)
          // 5
        } catch {
          // 6
          print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func getCheckListItems() -> [ChecklistItem] {
        // 1a
        var items = [ChecklistItem]()
        // 1b
        let path = dataFilePath(for: .checklistItems)
        // 2
        if let data = try? Data(contentsOf: path) {
          // 3
          let decoder = PropertyListDecoder()
          do {
            // 4
            items = try decoder.decode([ChecklistItem].self,
                                       from: data)
          } catch {
            print("Error decoding item array: \(error.localizedDescription)")
          }
        }
        
        return items
    }
    
    func save(checkListItems items: [ChecklistItem]) {
        // 1
        let encoder = PropertyListEncoder()
        // 2
        do {
          // 3
          let data = try encoder.encode(items)
          // 4
            try data.write(to: dataFilePath(for: .checklistItems),
                    options: Data.WritingOptions.atomic)
          // 5
        } catch {
          // 6
          print("Error encoding item array: \(error.localizedDescription)")
        }
    }

}

// MARK: - Private

extension StorageManagerImpl {
    private func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
      return paths[0]
    }

    private func dataFilePath(for type: FileType) -> URL {
      return documentsDirectory().appendingPathComponent(
        type.rawValue)
    }

}
