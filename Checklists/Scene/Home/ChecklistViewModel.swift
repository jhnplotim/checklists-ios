// 
//  ChecklistViewModel.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import Foundation

protocol ChecklistVM: AnyObject {
    func setup(viewDelegate: ChecklistViewDelegate)
}

protocol ChecklistTransition: AnyObject {
    func goToAddItem()

}

final class ChecklistViewModel {

    // typealias DI = AnyObject

    private weak var route: AppRoute?
    private weak var viewDelegate: ChecklistViewDelegate?

    // private var di: DI

    // MARK: - Constructor

    init(route: AppRoute? = nil) {
        // self.di = di
        self.route = route
    }

}

// MARK: - ChecklistVM

extension ChecklistViewModel: ChecklistVM {

    func setup(viewDelegate: ChecklistViewDelegate) {
        self.viewDelegate = viewDelegate
    }

}

// MARK: - ChecklistTransition

extension ChecklistViewModel: ChecklistTransition {
    func goToAddItem() {
        route?.goToAddCheckListItem(completion: addItem)
    }
}

// MARK: - Private

extension ChecklistViewModel {
    func addItem(addedItem: ChecklistRowView.Model) {
        self.viewDelegate?.addItem(newItem: addedItem)
    }
}
