// 
//  ChecklistItemCoordinator.swift
//  Checklists
//
//  Created by John Paul Otim on 30.05.22.
//

import UIKit
import Combine

// MARK: - Router Interface

protocol ChecklistItemRoute: AnyObject {
    func goToAddCheckListItem(completion: AddOrEditCheckListItem?)
    func goToEditCheckListItem(item: ChecklistItem, at position: Int, completion: AddOrEditCheckListItem?)
    /// Pop to prev view controller (if current is pushed onto stack)
    func popToPrevious()
}

final class ChecklistItemCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private var cancellables = Set<AnyCancellable>()
    private var checkList: ListItem
    private var checkListPosition: Int
    
    init(navigationController: UINavigationController, parentCoordinator: Coordinator? = nil, checkList: (Int, ListItem)) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
        self.checkList = checkList.1
        self.checkListPosition = checkList.0
    }
    
    func start() {
        di.cacheManager.lastSelectedListIndex = checkListPosition
        // Push
        push(ChecklistViewController.create(viewModel: ChecklistViewModel(di: di, route: self, listToView: checkList )))
    }
    
}

// MARK: - Router implementation

extension ChecklistItemCoordinator: ChecklistItemRoute {
    func goToEditCheckListItem(item: ChecklistItem, at position: Int, completion: AddOrEditCheckListItem?) {
        push(AddChecklistViewController.create(viewModel: AddChecklistViewModel(completion: completion, route: self, itemToEdit: (position, item))))
    }
    
    func goToAddCheckListItem(completion: AddOrEditCheckListItem?) {
        push(AddChecklistViewController.create(viewModel: AddChecklistViewModel(completion: completion, route: self)))
    }
    
    func popToPrevious() {
        pop()
    }
}

// MARK: - Private

extension ChecklistItemCoordinator {

}
