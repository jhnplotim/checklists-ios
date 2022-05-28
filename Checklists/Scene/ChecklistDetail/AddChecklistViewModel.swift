// 
//  AddChecklistViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 26.05.22.
//

import Foundation

typealias AddOrEditCheckList = ((ChecklistRowView.Model, Int?) -> Void)

protocol AddChecklistVM: AnyObject {
    func setup(viewDelegate: AddChecklistViewDelegate)
    func itemAddedOrEdited(titleName: String)
}

protocol AddChecklistTransition: AnyObject {
    func goBack()
}

final class AddChecklistViewModel {

    // typealias DI = AnyObject

    private weak var route: AppRoute?
    private var completion: AddOrEditCheckList?
    private var itemToEdit: (Int, ChecklistRowView.Model)?
    private weak var viewDelegate: AddChecklistViewDelegate?

    // private var di: DI

    // MARK: - Constructor

    init(completion: AddOrEditCheckList? = nil, route: AppRoute? = nil, itemToEdit: (Int, ChecklistRowView.Model)? = nil) {
        self.completion = completion
        self.route = route
        self.itemToEdit = itemToEdit
    }

}

// MARK: - AddChecklistVM

extension AddChecklistViewModel: AddChecklistVM {
    func itemAddedOrEdited(titleName: String) {
        if let itemToEdit = itemToEdit {
            completion?(ChecklistRowView.Model(title: titleName, isChecked: itemToEdit.1.isChecked), itemToEdit.0)
        } else {
            completion?(ChecklistRowView.Model(title: titleName, isChecked: false), nil)
        }
    }

    func setup(viewDelegate: AddChecklistViewDelegate) {
        self.viewDelegate = viewDelegate
        if let itemToEdit = itemToEdit {
            // Preload text field with item to edit
            self.viewDelegate?.preload(editItem: itemToEdit.1)
        }
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
