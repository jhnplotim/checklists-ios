// 
//  AddChecklistViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 26.05.22.
//

import Foundation

protocol AddChecklistVM: AnyObject {
    func setup(viewDelegate: AddChecklistViewDelegate)
    func addItem(titleName: String)
}

protocol AddChecklistTransition: AnyObject {
    func goBack()
}

final class AddChecklistViewModel {

    // typealias DI = AnyObject
    typealias AddCheckList = ((ChecklistRowView.Model) -> Void)

    private weak var route: AppRoute?
    private var completion: AddCheckList?
    private weak var viewDelegate: AddChecklistViewDelegate?

    // private var di: DI

    // MARK: - Constructor

    init(completion: AddCheckList? = nil, route: AppRoute? = nil) {
        self.completion = completion
        self.route = route
    }

}

// MARK: - AddChecklistVM

extension AddChecklistViewModel: AddChecklistVM {
    func addItem(titleName: String) {
        completion?(ChecklistRowView.Model(title: titleName, isChecked: false))
    }

    func setup(viewDelegate: AddChecklistViewDelegate) {
        self.viewDelegate = viewDelegate
    }

}

// MARK: - AddChecklistTransition

extension AddChecklistViewModel: AddChecklistTransition {
    func goBack() {
        route?.popToPrevious()
    }
}

// MARK: - Private

extension AddChecklistViewModel {

}
