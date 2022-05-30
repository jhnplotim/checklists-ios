// 
//  ChecklistCoordinator.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine

// MARK: - Router Interface

protocol ChecklistRoute: AnyObject {
    func goToCheckListItems(for checklist: ListItem, at position: Int)
    func goToAddCheckListItem(completion: AddOrEditCheckListItem?)
    func goToEditCheckListItem(item: ChecklistRowView.Model, at position: Int, completion: AddOrEditCheckListItem?)
    /// Pop to prev view controller (if current is pushed onto stack)
    func popToPrevious()
    func goToAddOrEditCheckList(item: (Int, ListRowView.Model)?, completion: AddOrEditCheckList?)
}

final class ChecklistCoordinator: Coordinator {
    
    private enum C {
        static let homePageIndex = -1
    }
    
    typealias DI = WithCacheManager & WithStorageManager
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var cancellables = Set<AnyCancellable>()
    private var di: DI
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil, di: DI) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.di = di
    }
    
    func start() {
        setRoot(AllListsViewController.create(viewModel: AllListsViewModel(di: di, route: self)))
        // Go to checklist items page if possible
        let lastSelectedIndex = di.cacheManager.lastSelectedListIndex
        if lastSelectedIndex != C.homePageIndex {
            if let item = di.storageManager.getItem(at: lastSelectedIndex) {
                goToCheckListItems(for: item, at: lastSelectedIndex)
            }
        }
    }
    
}

// MARK: - Router implementation

extension ChecklistCoordinator: ChecklistRoute {
    func goToCheckListItems(for checklist: ListItem, at position: Int) {
        // Save last opened checklist
        di.cacheManager.lastSelectedListIndex = position
        // Push
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

extension ChecklistCoordinator {

}
