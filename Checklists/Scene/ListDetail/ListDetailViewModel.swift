// 
//  ListDetailViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

protocol ListDetailVM: AnyObject {
    func setup(viewDelegate: ListDetailViewDelegate)
}

protocol ListDetailTransition: AnyObject {

}

final class ListDetailViewModel {

    typealias DI = AnyObject

    private weak var route: Coordinator?
    private weak var viewDelegate: ListDetailViewDelegate?

    private var di: DI

    // MARK: - Constructor

    init(di: DI, route: Coordinator? = nil) {
        self.di = di
        self.route = route
    }

}

// MARK: - ListDetailVM

extension ListDetailViewModel: ListDetailVM {

    func setup(viewDelegate: ListDetailViewDelegate) {
        self.viewDelegate = viewDelegate
    }

}

// MARK: - ListDetailTransition

extension ListDetailViewModel: ListDetailTransition {
    
}

// MARK: - Private

extension ListDetailViewModel {

}
