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
     /// Pop to prev view controller (if current is pushed onto stack)
    func popToPrevious()
    func goToAddOrEditCheckList(item: (Int, ListItem)?, completion: AddOrEditCheckList?)
}

final class ChecklistCoordinator: Coordinator {
    
    private enum C {
        static let homePageIndex = -1
        static let startingCheckListName = L.Feature.Checklist.Default.name
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
        // handle first run
        handleFirstRun()
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
        let checklistItemCoordinator = ChecklistItemCoordinator(navigationController: navigationController, parentCoordinator: self, checkList: (position, checklist))
        // Start
        checklistItemCoordinator.start()
        
        childCoordinators.append(checklistItemCoordinator)
       
    }
    
    func popToPrevious() {
        pop()
    }
    
    func goToAddOrEditCheckList(item: (Int, ListItem)?, completion: AddOrEditCheckList?) {
        push(ListDetailViewController.create(viewModel: ListDetailViewModel(route: self, completion: completion, itemToEdit: item)))
    }
}

// MARK: - Private

extension ChecklistCoordinator {
    func handleFirstRun() {
        if di.cacheManager.isFirstRun {
            // Add default first item to list
            di.storageManager.update(items: [ListItem(title: C.startingCheckListName)])
            
            // Set item as last selected index so that it is opened
            di.cacheManager.lastSelectedListIndex = 0
            di.cacheManager.isFirstRun = false
        }
    }
}
