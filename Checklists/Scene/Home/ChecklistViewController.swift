// 
//  ChecklistViewController.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine
 
protocol ChecklistViewDelegate: AnyObject {
    
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
        static let navigationTitle = L.App.name
    }

    // MARK: - Variable

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()

}

// MARK: - Lifecycle

extension ChecklistViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }

}

// MARK: - Private

extension ChecklistViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
    }

}

// MARK: - ChecklistViewDelegate

extension ChecklistViewController: ChecklistViewDelegate {
    
}
