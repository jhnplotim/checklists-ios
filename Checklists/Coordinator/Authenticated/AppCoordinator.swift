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
    func goToCheckListItems(for checklist: ListItem)
    func goToAddCheckListItem(completion: AddOrEditCheckListItem?)
    func goToEditCheckListItem(item: ChecklistRowView.Model, at position: Int, completion: AddOrEditCheckListItem?)
    /// Pop to prev view controller (if current is pushed onto stack)
    func popToPrevious()
    func goToAddOrEditCheckList(item: (Int, ListRowView.Model)?, completion: AddOrEditCheckList?)
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
    func goToCheckListItems(for checklist: ListItem) {
        push(ChecklistViewController.create(viewModel: ChecklistViewModel(di: di, route: self, listToView: checklist )))
    }
    func goToEditCheckListItem(item: ChecklistRowView.Model, at position: Int, completion: AddOrEditCheckListItem?) {
        push(AddChecklistViewController.create(viewModel: AddChecklistViewModel(completion: completion, route: self, itemToEdit: (position, item))))
    }
    
    func goToAddCheckListItem(completion: AddOrEditCheckListItem?) {
        push(AddChecklistViewController.create(viewModel: AddChecklistViewModel(completion: completion, route: self)))
    }
    
    func popToPrevious() {
        pop()
    }
    
    func goToAddOrEditCheckList(item: (Int, ListRowView.Model)?, completion: AddOrEditCheckList?) {
        push(ListDetailViewController.create(viewModel: ListDetailViewModel(route: self, completion: completion, itemToEdit: item)))
    }
}

// MARK: - Private

extension AppCoordinator {

}
