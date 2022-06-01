// 
//  CustomUINavigationViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 01.06.22.
//

import Foundation

protocol CustomUINavigationVM: AnyObject {
    func setup(viewDelegate: CustomUINavigationViewDelegate)
}

protocol CustomUINavigationTransition: AnyObject {

}

final class CustomUINavigationViewModel {

    private weak var viewDelegate: CustomUINavigationViewDelegate?

    // MARK: - Constructor

    init() {
    }

}

// MARK: - CustomUINavigationVM

extension CustomUINavigationViewModel: CustomUINavigationVM {

    func setup(viewDelegate: CustomUINavigationViewDelegate) {
        self.viewDelegate = viewDelegate
    }

}

// MARK: - CustomUINavigationTransition

extension CustomUINavigationViewModel: CustomUINavigationTransition {
    
}

// MARK: - Private

extension CustomUINavigationViewModel {

}
