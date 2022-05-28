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
    func goToCheckListItems()
    func goToAddCheckListItem(completion: AddOrEditCheckList?)
    func goToEditCheckListItem(item: ChecklistRowView.Model, at position: Int, completion: AddOrEditCheckList?)
    /// Pop to prev view controller (if current is pushed onto stack)
    func popToPrevious()
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
        setRoot(AllListsViewController.create(viewModel: AllListsViewModel(di: di, route: self)))
    }
    
}

// MARK: - Router implementation

extension AppCoordinator: AppRoute {
    func goToCheckListItems() {
        // FIXME: Pass check list id
        push(ChecklistViewController.create(viewModel: ChecklistViewModel(di: di, route: self)))
    }
    func goToEditCheckListItem(item: ChecklistRowView.Model, at position: Int, completion: AddOrEditCheckList?) {
        push(AddChecklistViewController.create(viewModel: AddChecklistViewModel(completion: completion, route: self, itemToEdit: (position, item))))
    }
    
    func goToAddCheckListItem(completion: AddOrEditCheckList?) {
        push(AddChecklistViewController.create(viewModel: AddChecklistViewModel(completion: completion, route: self)))
    }
    
    func popToPrevious() {
        pop()
    }
}

// MARK: - Private

extension AppCoordinator {

}
