// 
//  ListDetailViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import UIKit
import Combine
 
protocol ListDetailViewDelegate: AnyObject {
    
}

// MARK: - Class

final class ListDetailViewController: UIViewController {

    typealias ViewModel = ListDetailVM & ListDetailTransition
    
    static func create(viewModel: ListDetailViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    
    // MARK: - Constant

    private enum C {
        static let navigationTitle = "Navigation Title"
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

}

// MARK: - Private

extension ListDetailViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
    }

}

// MARK: - ListDetailViewDelegate

extension ListDetailViewController: ListDetailViewDelegate {
    
}
