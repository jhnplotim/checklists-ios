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

final class ListDetailViewController: BaseUITableViewController, UITextFieldDelegate {

    typealias ViewModel = ListDetailVM & ListDetailTransition
    
    static func create(viewModel: ListDetailViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    
    // MARK: - Constant

    private enum C {
        static let addListTitle = L.Feature.Listdetail.Add.title
        static let editListTitle = L.Feature.Listdetail.Edit.title
        static let textFieldPlaceHolder = L.Feature.Listdetail.Textfield.placeholder
    }

    // MARK: - Variable

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Actions
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        viewModel.goBack()
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        // Add the following line
        let value = textField.text ?? ""
        
        if !value.isEmpty {
            print("Contents of the text field: \(value)")
            // TODO: Handle empty inputs
            viewModel.itemAddedOrEdited(titleName: value)
        }
        
        viewModel.goBack()
    }
    
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
        textField.delegate = self
    }

}

// MARK: - ListDetailViewDelegate

extension ListDetailViewController: ListDetailViewDelegate {
    func preload(editItem: ListRowView.Model) {
        textField.text = editItem.title
        navigationItem.title = C.editListTitle
        doneBarBtn.isEnabled = true
    }
}

// MARK: - Table View Delegates
extension ListDetailViewController {
    // Disable row selection
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

// MARK: - UITextFieldDelegate
extension ListDetailViewController {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let oldText = textField.text ?? ""
        guard let stringRange = Range(range, in: oldText) else { return true }
        let newText = oldText.replacingCharacters(in: stringRange, with: string)
        
        doneBarBtn.isEnabled = !newText.isEmpty
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Clear Button clicked, disable doneBarBtn
        doneBarBtn.isEnabled = false
        return true
    }
}
