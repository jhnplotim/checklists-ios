// 
//  ChecklistViewModel.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import Foundation

protocol ChecklistVM: AnyObject {
    func setup(viewDelegate: ChecklistViewDelegate)
    func loadChecklistItems() -> [ChecklistItem]
    func save(items: [ChecklistItem])
}

protocol ChecklistTransition: AnyObject {
    func goToAddItem()
    
    func goToEdit(item: ChecklistRowView.Model, at position: Int)

}

final class ChecklistViewModel {

    typealias DI = WithStorageManager

    private weak var route: AppRoute?
    private weak var viewDelegate: ChecklistViewDelegate?

    // Dependencies
    private var di: DI

    // MARK: - Constructor

    init(di: DI, route: AppRoute? = nil) {
        self.di = di
        self.route = route
    }

}

// MARK: - ChecklistVM

extension ChecklistViewModel: ChecklistVM {
    func setup(viewDelegate: ChecklistViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func save(items: [ChecklistItem]) {
        di.storageManager.save(checkListItems: items)
    }
    
    func loadChecklistItems() -> [ChecklistItem] {
        return di.storageManager.getCheckListItems()
    }

}

// MARK: - ChecklistTransition

extension ChecklistViewModel: ChecklistTransition {
    func goToEdit(item: ChecklistRowView.Model, at position: Int) {
        route?.goToEditCheckListItem(item: item, at: position, completion: addOrEditItemCompletion)
    }
    
    func goToAddItem() {
        route?.goToAddCheckListItem(completion: addOrEditItemCompletion)
    }
}

// MARK: - Private

extension ChecklistViewModel {
    func addOrEditItemCompletion(item: ChecklistRowView.Model, at position: Int? = nil) {
        if let position = position {
            self.viewDelegate?.update(item: item, at: position)
        } else {
            self.viewDelegate?.add(newItem: item)
        }
    }
}
