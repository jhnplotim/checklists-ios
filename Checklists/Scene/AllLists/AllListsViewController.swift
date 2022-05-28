// 
//  AllListsViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit
import Combine
 
protocol AllListsViewDelegate: AnyObject {
    
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
    // private var items = [Item]()
    private var items = [Item.listRow(model: ListRowView.Model(title: "Errands"))]

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()

}

// MARK: - Lifecycle

extension AllListsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        registerCells()
        viewModel.setup(viewDelegate: self)
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
        // TODO: Open a particular check list
        viewModel.openCheckListItems()
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        viewModel.openCheckListItems()
    }
    
}
