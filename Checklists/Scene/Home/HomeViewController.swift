// 
//  HomeViewController.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine
 
protocol HomeViewDelegate: AnyObject {
    
}

// MARK: - Class

final class HomeViewController: BaseUIViewController {

    typealias ViewModel = HomeVM & HomeTransition
    
    static func create(viewModel: HomeViewModel) -> Self {
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

extension HomeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.setup(viewDelegate: self)
    }

}

// MARK: - Private

extension HomeViewController {

    private func setupView() {
        navigationItem.title = C.navigationTitle
    }

}

// MARK: - HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    
}
