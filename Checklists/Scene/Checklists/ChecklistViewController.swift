// 
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine
 
protocol ChecklistViewDelegate: AnyObject {
    func add(newItem: ChecklistItem)
    func update(item: ChecklistItem, at position: Int)
    func loadCheckList(_ checkList: ListItem)
}

// MARK: - Class

final class ChecklistViewController: BaseUITableViewController, UINavigationControllerDelegate {

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
    
    private var checkList = ListItem(title: "")

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
        navigationController?.delegate = self
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
    func update(item: ChecklistItem, at position: Int) {
        // No need to update here since we passed reference which was modified on the other page
        // checkList.checkListItems[position] = item
        // Update item in list path of index to update
        let path = [IndexPath(row: position, section: 0)]
        // Update table view
        tableView.reloadRows(at: path, with: .automatic)
    }
    
    func add(newItem: ChecklistItem) {
        // Position to insert item
        let newRowIndex = checkList.checkListItems.count
        // Append item to list
        checkList.checkListItems.append(newItem)
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
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate & DataSource
extension ChecklistViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkList.checkListItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = checkList.checkListItems.safeGet(at: indexPath.row), let cell = tableView.dequeueReusableCell(fromClass: ChecklistRowTableViewCell.self, for: indexPath) {
            cell.setup(model: item.modelCheckListListItem)
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = checkList.checkListItems.safeGet(at: indexPath.row) {
            item.toggle()
        }

        // Deselect the row
        tableView.deselectRow(at: indexPath, animated: true)
        // Reload the table view at selected path
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        checkList.checkListItems.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        if let item = checkList.checkListItems.safeGet(at: indexPath.row) {
            viewModel.goToEdit(item: item, at: indexPath.row)
        }
    }
}

// MARK: - UINavigationControllerDelegate
extension ChecklistViewController {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Was the back button tapped?
          if viewController is AllListsViewController {
              // Navigating back to AllListViewController
              viewModel.resetSelectedIndex()
          }
    }
}
