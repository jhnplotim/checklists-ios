// 
//  AllListsViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

protocol AllListsVM: AnyObject {
    func setup(viewDelegate: AllListsViewDelegate)
}

protocol AllListsTransition: AnyObject {
    func openCheckListItems()
}

final class AllListsViewModel {

    typealias DI = AnyObject

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

}

// MARK: - AllListsTransition

extension AllListsViewModel: AllListsTransition {
    func openCheckListItems() {
        route?.goToCheckListItems()
    }
}

// MARK: - Private

extension AllListsViewModel {

}
