// 
//  AddChecklistViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 26.05.22.
//

import Foundation

typealias AddOrEditCheckListItem = ((ChecklistItem, Int?) -> Void)

protocol AddChecklistVM: AnyObject {
    func setup(viewDelegate: AddChecklistViewDelegate)
    func itemAddedOrEdited(titleName: String)
}

protocol AddChecklistTransition: AnyObject {
    func goBack()
}

final class AddChecklistViewModel {

    // typealias DI = AnyObject

    private weak var route: ChecklistItemRoute?
    private var completion: AddOrEditCheckListItem?
    private var itemToEdit: (Int, ChecklistItem)?
    private weak var viewDelegate: AddChecklistViewDelegate?

    // private var di: DI

    // MARK: - Constructor

    init(completion: AddOrEditCheckListItem? = nil, route: ChecklistItemRoute? = nil, itemToEdit: (Int, ChecklistItem)? = nil) {
        self.completion = completion
        self.route = route
        self.itemToEdit = itemToEdit
    }

}

// MARK: - AddChecklistVM

extension AddChecklistViewModel: AddChecklistVM {
    func setup(viewDelegate: AddChecklistViewDelegate) {
        self.viewDelegate = viewDelegate
        if let itemToEdit = itemToEdit {
            // Preload Item to Edit and put page in edit mode
            self.viewDelegate?.preload(editItem: itemToEdit.1)
        }
    }
    
    func itemAddedOrEdited(titleName: String) {
        if let itemToEdit = itemToEdit {
            // Set the details
            itemToEdit.1.title = titleName
            
            completion?(itemToEdit.1, itemToEdit.0)
        } else {
            completion?(ChecklistItem(title: titleName), nil)
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
