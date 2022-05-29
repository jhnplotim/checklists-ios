// 
//  AllListsViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

protocol AllListsVM: AnyObject {
    func setup(viewDelegate: AllListsViewDelegate)
    func loadChecklists()
    func updateStorageMgr(items: [ListItem])
}

protocol AllListsTransition: AnyObject {
    func openCheckListItems(for checklist: ListItem, at position: Int)
    func goToAddCheckList()
    func goToEditCheckList(item: ListRowView.Model, at position: Int)
}

final class AllListsViewModel {

    typealias DI = WithStorageManager & WithCacheManager

    private weak var route: AppRoute?
    private weak var viewDelegate: AllListsViewDelegate?

    private var di: DI

    // MARK: - Constructor

    init(di: DI, route: AppRoute? = nil) {
        self.di = di
        self.route = route
    }

}

// MARK: - AllListsVM

extension AllListsViewModel: AllListsVM {

    func setup(viewDelegate: AllListsViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func loadChecklists() {
        self.viewDelegate?.loadChecklists(di.storageManager.load())
    }
    
    func updateStorageMgr(items: [ListItem]) {
        di.storageManager.update(items: items)
    }

}

// MARK: - AllListsTransition

extension AllListsViewModel: AllListsTransition {
    func openCheckListItems(for checklist: ListItem, at position: Int) {
        
        route?.goToCheckListItems(for: checklist, at: position)
    }
    
    func goToAddCheckList() {
        route?.goToAddOrEditCheckList(item: nil, completion: listAdded)
    }
    
    func goToEditCheckList(item: ListRowView.Model, at position: Int) {
        route?.goToAddOrEditCheckList(item: (position, item), completion: listAdded)
    }
}

// MARK: - Private

extension AllListsViewModel {
    func listAdded(model: ListRowView.Model, at position: Int?) {
        if let position = position {
            self.viewDelegate?.update(item: model, at: position)
        } else {
            self.viewDelegate?.add(newItem: model)
        }
    }
}
