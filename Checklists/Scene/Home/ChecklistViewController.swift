// 
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine
 
protocol ChecklistViewDelegate: AnyObject {
    func add(newItem: ChecklistRowView.Model)
    func update(item: ChecklistRowView.Model, at position: Int)
}

// MARK: - Item for TableViewController
private enum Item: Codable {
    
    case checklistRow(model: ChecklistRowView.Model)
    
}

// MARK: - Class

final class ChecklistViewController: BaseUITableViewController {

    typealias ViewModel = ChecklistVM & ChecklistTransition
    
    static func create(viewModel: ChecklistViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    
    // MARK: - Constant

    private enum C {
        static let navigationTitle = L.Feature.Checklists.title
        static let fileName = "Checklists.plist"
    }

    // MARK: - Variable
    private var items = [Item]()

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Actions
    @IBAction func addItem() {
        viewModel.goToAddItem()
    }

}

// MARK: - Lifecycle

extension ChecklistViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        registerCells()
        viewModel.setup(viewDelegate: self)
        items = viewModel.loadChecklistItems().items
    }

}

// MARK: - Private

extension ChecklistViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func registerCells() {
        tableView.registerCell(fromClass: ChecklistRowTableViewCell.self)
    }

}

// MARK: - ChecklistViewDelegate

extension ChecklistViewController: ChecklistViewDelegate {
    func update(item: ChecklistRowView.Model, at position: Int) {
        // Update item in list
        items[position] = Item.checklistRow(model: item)
        // path of index to update
        let path = [IndexPath(row: position, section: 0)]
        // Update table view
        tableView.reloadRows(at: path, with: .automatic)
        viewModel.save(items: items.checklistItems)
    }
    
    func add(newItem: ChecklistRowView.Model) {
        // Position to insert item
        let newRowIndex = items.count

        // Append item to list
        items.append(Item.checklistRow(model: newItem))

        // Updated the table view
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        viewModel.save(items: items.checklistItems)
    }
}

// MARK: - UITableViewDelegate
extension ChecklistViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
            
        case .checklistRow(model: let model):
            let cell = tableView.dequeueReusableCell(fromClass: ChecklistRowTableViewCell.self, for: indexPath)
            
            cell?.setup(model: model)
            return cell ?? UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case let .checklistRow(model) = items[indexPath.row] {
            // Update the item list at that row index by toggling the isChecked property and later reload the table view
            items[indexPath.row] = Item.checklistRow(model: ChecklistRowView.Model(title: model.title, isChecked: !model.isChecked))
        }
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        // Reload the table view at selected path
        tableView.reloadRows(at: [indexPath], with: .automatic)
        viewModel.save(items: items.checklistItems)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        items.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        viewModel.save(items: items.checklistItems)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if case let .checklistRow(model) = items[indexPath.row] {
            viewModel.goToEdit(item: model, at: indexPath.row)
        }
    }
}

// MARK: - Array extension for [ChecklistItem] -> [Item]
extension Array where Element == ChecklistItem {
    fileprivate var items: [Item] {
        return self.map { Item.checklistRow(model: ChecklistRowView.Model(title: $0.title, isChecked: $0.isChecked))}
    }
}

// MARK: - Array extension for [Item] -> [ChecklistItem]
extension Array where Element == Item {
    fileprivate var checklistItems: [ChecklistItem] {
        return self.compactMap {
            switch $0 {
            case .checklistRow(model: let model):
                return ChecklistItem(title: model.title, isChecked: model.isChecked)
            }
        }
    }
}
