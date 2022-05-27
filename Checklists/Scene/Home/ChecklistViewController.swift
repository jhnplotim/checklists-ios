// 
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine
 
protocol ChecklistViewDelegate: AnyObject {
    func addItem(newItem: ChecklistRowView.Model)
}

// MARK: - Class

final class ChecklistViewController: BaseUITableViewController {
    
    enum Item {
        
        case checklistRow(model: ChecklistRowView.Model)
        
    }

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
        loadItems()
    }

}

// MARK: - Private

extension ChecklistViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    private func loadItems() {
        items = [Item.checklistRow(model: ChecklistRowView.Model(title: "Shopping", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Dubai Trip", isChecked: true)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Soccer", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Learn ML in Python", isChecked: true)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Go visit Bae", isChecked: true)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Do laundry", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Write Code", isChecked: true)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Apply to Google", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Apply to Apple", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Apply to Netflix", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Finish Naturalisation Test app", isChecked: false)),
                 Item.checklistRow(model: ChecklistRowView.Model(title: "Build naturalisation app backend", isChecked: true))]
        tableView.reloadData()
    }
    
    private func registerCells() {
        tableView.registerCell(fromClass: ChecklistRowTableViewCell.self)
        tableView.registerCell(fromClass: SeparatorRowTableViewCell.self)
    }

}

// MARK: - ChecklistViewDelegate

extension ChecklistViewController: ChecklistViewDelegate {
    func addItem(newItem: ChecklistRowView.Model) {
        // Position to insert item
        let newRowIndex = items.count

        // Append item to list
        items.append(Item.checklistRow(model: newItem))

        // Updated the table view
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
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
            
            if model.isChecked {
                // Toggle checkmark
                cell?.accessoryType = .checkmark
            } else {
                // Remove check mark
                cell?.accessoryType = .none
            }
            
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
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // 1
        items.remove(at: indexPath.row)
        
        // 2
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
}
