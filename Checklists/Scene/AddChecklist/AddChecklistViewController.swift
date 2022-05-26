// 
//  AddChecklistViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 26.05.22.
//

import UIKit
import Combine
 
protocol AddChecklistViewDelegate: AnyObject {
    
}

// MARK: - Class

final class AddChecklistViewController: BaseUITableViewController {

    typealias ViewModel = AddChecklistVM & AddChecklistTransition
    
    static func create(viewModel: AddChecklistViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    
    // MARK: - Constant

    private enum C {
        static let navigationTitle = L.Feature.Checklists.Add.title
    }

    // MARK: - Variable

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    
    // MARK:- Actions
    @IBAction func cancel() {
      navigationController?.popViewController(animated: true)
    }

    @IBAction func done() {
      navigationController?.popViewController(animated: true)
    }

}

// MARK: - Lifecycle

extension AddChecklistViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }

}

// MARK: - Private

extension AddChecklistViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
        navigationItem.largeTitleDisplayMode = .never
    }

}

// MARK: - AddChecklistViewDelegate

extension AddChecklistViewController: AddChecklistViewDelegate {
    
}
