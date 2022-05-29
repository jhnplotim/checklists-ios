// 
//  StorageManagerImpl.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit

// MARK: - Manager Implementation

final class StorageManagerImpl: StorageManager {
    
    private static var sharedInstance: StorageManagerImpl?
    
    // MARK: - Singleton
    // swiftlint:disable force_cast
    /// Get shared instance of storage manager
    static func getSharedInstance(di: DependencyContainer) -> Self {
        if let sharedInstance = sharedInstance {
            return sharedInstance as! Self
        } else {
            sharedInstance = StorageManagerImpl(di: di)
            return sharedInstance as! Self
        }
    }

    // MARK: - Typealias

    typealias DI = DependencyContainer

    // MARK: - Constant
    
    private enum C {
        static let fileName = "Checklists.plist"
    }

    private let di: DI
    
    private var items: [ListItem] = []

    // MARK: - Initializer

    private init(di: DependencyContainer) {
        self.di = di
        // load checklists into memory
        self.items = loadChecklistsInToMemory()
    }

}

// MARK: - Public

extension StorageManagerImpl {
    func load() -> [ListItem] {
        // Return reference to preloaded list
        return items
    }
    
    func save() {
        // 1
        let encoder = PropertyListEncoder()
        // 2
        do {
          // 3
          let data = try encoder.encode(items)
          // 4
            try data.write(to: dataFilePath(forFileWithName: C.fileName),
                    options: Data.WritingOptions.atomic)
          // 5
        } catch {
          // 6
          print("Error encoding item array: \(error.localizedDescription)")
        }
    }
    
    func update(items: [ListItem]) {
        self.items = items
    }
    
    func getItem(at position: Int) -> ListItem? {
        if items.isEmpty || items.count <= position {
            return nil
        } else {
            return items[position]
        }
    }

}

// MARK: - Private

extension StorageManagerImpl {
    private func loadChecklistsInToMemory() -> [ListItem] {
        // 1a
        var items = [ListItem]()
        // 1b
        let path = dataFilePath(forFileWithName: C.fileName)
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
    
    private func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(for: .documentDirectory,
                                            in: .userDomainMask)
      return paths[0]
    }

    private func dataFilePath(forFileWithName fileName: String) -> URL {
      return documentsDirectory().appendingPathComponent(
        fileName)
    }

}
