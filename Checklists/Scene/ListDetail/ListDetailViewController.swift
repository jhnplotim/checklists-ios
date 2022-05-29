// 
//  ListDetailViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit
import Combine
 
protocol ListDetailViewDelegate: AnyObject {
    func preload(editItem: ListRowView.Model)
}

// MARK: - Class

final class ListDetailViewController: BaseUITableViewController {

    typealias ViewModel = ListDetailVM & ListDetailTransition
    
    static func create(viewModel: ListDetailViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Constant

    private enum C {
        static let addListTitle = L.Feature.Listdetail.Add.title
        static let editListTitle = L.Feature.Listdetail.Edit.title
        static let textFieldPlaceHolder = L.Feature.Listdetail.Textfield.placeholder
    }

    // MARK: - Variable

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()

}

// MARK: - Lifecycle

extension ListDetailViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make text field first responder on load page
        textField.becomeFirstResponder()
    }

}

// MARK: - Private

extension ListDetailViewController {

    private func setupView() {
        navigationItem.title = C.addListTitle
        // Disable large titles for this view controller
        navigationItem.largeTitleDisplayMode = .never
        // Set placeholder of text field
        textField.placeholder = C.textFieldPlaceHolder
    }

}

// MARK: - ListDetailViewDelegate

extension ListDetailViewController: ListDetailViewDelegate {
    func preload(editItem: ListRowView.Model) {
        textField.text = editItem.title
        navigationItem.title = C.editListTitle
    }
}

// MARK: - Table View Delegates
extension ListDetailViewController {
    // Disable row selection
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
