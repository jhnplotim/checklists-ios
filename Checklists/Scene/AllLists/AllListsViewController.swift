// 
//  AllListsViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit
import Combine
 
protocol AllListsViewDelegate: AnyObject {
    func add(newItem: ListRowView.Model)
    func update(item: ListRowView.Model, at position: Int)
    func loadChecklists(_ listItems: [ListItem])
}

// MARK: - Item for TableViewController
private enum Item: Codable {
    case listRow(model: ListRowView.Model)
}

// MARK: - Class

final class AllListsViewController: BaseUITableViewController {

    typealias ViewModel = AllListsVM & AllListsTransition
    
    static func create(viewModel: AllListsViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    
    // MARK: - Constant

    private enum C {
        static let navigationTitle = L.Feature.Alllists.title
    }

    // MARK: - Variable
    private var checkLists: [ListItem] = [] {
        didSet {
            items = checkLists.items
        }
    }
    private var items: [Item] = []

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Actions
    @IBAction func addList(_ sender: UIBarButtonItem) {
        viewModel.goToAddCheckList()
    }
    
}

// MARK: - Lifecycle

extension AllListsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        registerCells()
        viewModel.setup(viewDelegate: self)
        // Tell VM to load data
        viewModel.loadChecklists()
        
    }

}

// MARK: - Private

extension AllListsViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
        // Enable large titles
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func registerCells() {
        tableView.registerCell(fromClass: ListRowTableViewCell.self)
    }

}

// MARK: - AllListsViewDelegate

extension AllListsViewController: AllListsViewDelegate {
    func add(newItem: ListRowView.Model) {
        // Position to insert item
        let newRowIndex = checkLists.count
        // Append item to list
        // TODO: Check if didSet updates the items
        checkLists.append(newItem.listItem)
        // Updated the table view
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        viewModel.updateStorageMgr(items: checkLists)
    }
    
    func update(item: ListRowView.Model, at position: Int) {
        // Update item in list
        // TODO: Check if didSet updates the items
        checkLists[position] = item.listItem
        // path of index to update
        let path = [IndexPath(row: position, section: 0)]
        // Update table view
        tableView.reloadRows(at: path, with: .automatic)
        viewModel.updateStorageMgr(items: checkLists)
    }
    
    func loadChecklists(_ listItems: [ListItem]) {
        checkLists = listItems
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSource

extension AllListsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row] {
        case .listRow(model: let model):
            let cell = tableView.dequeueReusableCell(fromClass: ListRowTableViewCell.self, for: indexPath)
            cell?.setup(model: model)
            return cell ?? UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        let checkList = checkLists[indexPath.row]
        
        viewModel.openCheckListItems(for: checkList)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if case let .listRow(model) = items[indexPath.row] {
            viewModel.goToEditCheckList(item: model, at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        checkLists.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
        
        viewModel.updateStorageMgr(items: checkLists)
    }
    
}

// MARK: - Array extension for [ListItem] -> [Item]
extension Array where Element == ListItem {
    fileprivate var items: [Item] {
        return self.map { Item.listRow(model: $0.modelListItem)}
    }
}

// MARK: - Array extension for [Item] -> [ListItem]
extension Array where Element == Item {
    fileprivate var listItems: [ListItem] {
        return self.compactMap {
            switch $0 {
            case .listRow(model: let model):
                return model.listItem
            }
        }
    }
}
