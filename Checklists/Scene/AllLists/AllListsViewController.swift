// 
//  AllListsViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit
import Combine
 
protocol AllListsViewDelegate: AnyObject {
    func add(newItem: ListItem)
    func update(item: ListItem, at position: Int)
    func loadChecklists(_ dataModel: DataModel)
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
    private var dataModel: DataModel = DataModel()

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
    
    override func viewWillAppear(_ animated: Bool) {
        // Reload table when user add, edits or deletes items from Checklist screen and navigates back
        tableView.reloadData()
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
    func add(newItem: ListItem) {
        // Position to insert item
        // Append item to list
        dataModel.append(newItem)
        // Updated the table view
        tableView.reloadData()
    }
    
    func update(item: ListItem, at position: Int) {
        // item param is not used since we passed the reference and modified the reference in the child view controller. The same reference that will be saved later
        // Update item in list
        // path of index to update
        // Update table view
        dataModel.sort()
        tableView.reloadData()
    }
    
    func loadChecklists(_ dataModel: DataModel) {
        self.dataModel = dataModel
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSource

extension AllListsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let item = dataModel.getItem(at: indexPath.row), let cell = tableView.dequeueReusableCell(fromClass: ListRowTableViewCell.self, for: indexPath) {
            cell.setup(model: item.modelListItem)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let item = dataModel.getItem(at: indexPath.row) {
            viewModel.openCheckListItems(for: item, at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let item = dataModel.getItem(at: indexPath.row) {
            viewModel.goToEditCheckList(item: item, at: indexPath.row)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        dataModel.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
}
