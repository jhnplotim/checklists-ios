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
    func save(items: [ListItem])
}

protocol AllListsTransition: AnyObject {
    func openCheckListItems(for checklist: ListItem)
    func goToAddCheckList()
    func goToEditCheckList(item: ListRowView.Model, at position: Int)
}

final class AllListsViewModel {

    typealias DI = WithStorageManager

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
    
    func save(items: [ListItem]) {
        di.storageManager.save(listItems: items)
    }
    
    func loadChecklists() {
        let results = di.storageManager.getCheckLists()
        self.viewDelegate?.loadChecklists(results)
    }

}

// MARK: - AllListsTransition

extension AllListsViewModel: AllListsTransition {
    func openCheckListItems(for checklist: ListItem) {
        route?.goToCheckListItems(for: checklist)
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
