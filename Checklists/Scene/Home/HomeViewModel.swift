// 
//  HomeViewModel.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import Foundation

protocol HomeVM: AnyObject {
    func setup(viewDelegate: HomeViewDelegate)
}

protocol HomeTransition: AnyObject {

}

final class HomeViewModel {

    // typealias DI = AnyObject

    private weak var route: AppRoute?
    private weak var viewDelegate: HomeViewDelegate?

    // private var di: DI

    // MARK: - Constructor

    init(route: AppRoute? = nil) {
        // self.di = di
        self.route = route
    }

}

// MARK: - HomeVM

extension HomeViewModel: HomeVM {

    func setup(viewDelegate: HomeViewDelegate) {
        self.viewDelegate = viewDelegate
    }

}

// MARK: - HomeTransition

extension HomeViewModel: HomeTransition {
    
}

// MARK: - Private

extension HomeViewModel {

}
