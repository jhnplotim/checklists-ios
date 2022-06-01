// 
//  CustomUINavigationViewController.swift
//  Checklists
//
//  Created by John Paul Otim on 01.06.22.
//

import UIKit
import Combine
 
protocol CustomUINavigationViewDelegate: AnyObject {
    
}

// MARK: - Class

final class CustomUINavigationViewController: UINavigationController {

    typealias ViewModel = CustomUINavigationVM & CustomUINavigationTransition
    
    static func create(viewModel: CustomUINavigationViewModel) -> Self {
        let instance = makeInstance()
        instance.viewModel = viewModel

        return instance
    }

    // MARK: - Outlet
    
    // MARK: - Constant

    private enum C {
    }

    // MARK: - Variable

    private var viewModel: ViewModel!
    private var cancellables = Set<AnyCancellable>()

}

// MARK: - Lifecycle

extension CustomUINavigationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }

}

// MARK: - Private

extension CustomUINavigationViewController {

    private func setupView() {
    }

}

// MARK: - CustomUINavigationViewDelegate

extension CustomUINavigationViewController: CustomUINavigationViewDelegate {
    
}
