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
    func loadCheckList(_ checkList: ListItem)
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
    }

    // MARK: - Variable
    
    private var checkList: ListItem = ListItem(title: "") {
        didSet {
            // TODO: Uncomment to investigate
            // items = checkList.checkListItems.items
        }
    }
    
    // TODO: Remove Quick fix later since didSet in checkList: ListItem property runs only once
    private var checkListItems: [ChecklistItem] = [] {
        didSet {
            items = checkListItems.items
        }
    }
    
    private var items: [Item] = []

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
    }

}

// MARK: - Private

extension ChecklistViewController {

    private func setupView() {
        // Disable large titles for this view controller
        navigationItem.largeTitleDisplayMode = .never
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func registerCells() {
        tableView.registerCell(fromClass: ChecklistRowTableViewCell.self)
    }
    
}

// MARK: - ChecklistViewDelegate

extension ChecklistViewController: ChecklistViewDelegate {
    func update(item: ChecklistRowView.Model, at position: Int) {
        checkList.checkListItems[position] = item.checklistItem
        // TODO: Investigate why didSet on checkList is not called.
        // FIXME: Fix this later when we sort out didSet issue
        updateCheckList(newItems: checkList.checkListItems)
        // Update item in list path of index to update
        let path = [IndexPath(row: position, section: 0)]
        // Update table view
        tableView.reloadRows(at: path, with: .automatic)
    }
    
    func add(newItem: ChecklistRowView.Model) {
        // Position to insert item
        let newRowIndex = items.count
        // Append item to list
        checkList.checkListItems.append(newItem.checklistItem)
        updateCheckList(newItems: checkList.checkListItems)
        // Updated the table view
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func loadCheckList(_ checkList: ListItem) {
        // Load title
        navigationItem.title = checkList.title
        // Load checklist items
        self.checkList = checkList
        // Part of fix
        checkListItems = checkList.checkListItems
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSource
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
        if case .checklistRow(_) = items[indexPath.row] {
            // Update the item list at that row index by toggling the isChecked property and later reload the table view
            checkList.checkListItems[indexPath.row].toggle()
            updateCheckList(newItems: checkList.checkListItems)
        }
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        // Reload the table view at selected path
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        checkList.checkListItems.remove(at: indexPath.row)
        updateCheckList(newItems: checkList.checkListItems)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if case .checklistRow(_) = items[indexPath.row] {
            viewModel.goToEdit(item: checkList.checkListItems[indexPath.row].modelCheckListListItem, at: indexPath.row)
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

extension ChecklistViewController {
    func updateCheckList(newItems: [ChecklistItem]) {
        checkList.checkListItems = newItems
        checkListItems = newItems
    }
}
