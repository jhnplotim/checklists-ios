// 
//  AddChecklistViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 26.05.22.
//

import UIKit
import Combine
 
protocol AddChecklistViewDelegate: AnyObject {
    func preload(editItem: ChecklistRowView.Model)
}

// MARK: - Class

final class AddChecklistViewController: BaseUITableViewController, UITextFieldDelegate {

    typealias ViewModel = AddChecklistVM & AddChecklistTransition
    
    static func create(viewModel: AddChecklistViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarBtn: UIBarButtonItem!
    
    // MARK: - Constant

    private enum C {
        static let addItemTitle = L.Feature.Checklistitemdetail.Add.title
        static let editItemTitle = L.Feature.Checklistitemdetail.Edit.title
        static let textFieldPlaceHolder = L.Feature.Checklistitemdetail.Textfield.placeholder
    }

    // MARK: - Variable

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Actions
    @IBAction func cancel() {
        viewModel.goBack()
    }

    @IBAction func done() {
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

extension AddChecklistViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Make text field first responder on load
        textField.becomeFirstResponder()
    }

}

// MARK: - Private

extension AddChecklistViewController {

    private func setupView() {
        navigationItem.title = C.addItemTitle
        // Disable large titles for this view controller
        navigationItem.largeTitleDisplayMode = .never
        textField.placeholder = C.textFieldPlaceHolder
        textField.delegate = self
    }

}

// MARK: - AddChecklistViewDelegate

extension AddChecklistViewController: AddChecklistViewDelegate {
    func preload(editItem: ChecklistRowView.Model) {
        textField.text = editItem.title
        navigationItem.title = C.editItemTitle
        doneBarBtn.isEnabled = true
    }
    
}

// MARK: - Table View Delegates
extension AddChecklistViewController {
    // Disable row selection
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

// MARK: - UITextFieldDelegate
extension AddChecklistViewController {
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
