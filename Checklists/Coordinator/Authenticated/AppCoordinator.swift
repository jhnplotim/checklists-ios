// 
//  AppCoordinator.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine

// MARK: - Router Interface

protocol AppRoute: AnyObject {

}

final class AppCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        setRoot(ChecklistViewController.create(viewModel: ChecklistViewModel(route: self)))
    }
    
}

// MARK: - Router implementation

extension AppCoordinator: AppRoute {
    
}

// MARK: - Private

extension AppCoordinator {

}
