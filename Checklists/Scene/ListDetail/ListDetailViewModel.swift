// 
//  ListDetailViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

typealias AddOrEditCheckList = ((ListItem, Int?) -> Void)

protocol ListDetailVM: AnyObject {
    func setup(viewDelegate: ListDetailViewDelegate)
    func itemAddedOrEdited(titleName: String)
}

protocol ListDetailTransition: AnyObject {
    func goBack()
}

final class ListDetailViewModel {

    // typealias DI = AnyObject

    private weak var route: ChecklistRoute?
    private weak var viewDelegate: ListDetailViewDelegate?

    // private var di: DI
    private var completion: AddOrEditCheckList?
    // TODO: Change to using ListItem object itself
    private var itemToEdit: (Int, ListItem)?

    // MARK: - Constructor

    init(route: ChecklistRoute? = nil, completion: AddOrEditCheckList? = nil, itemToEdit: (Int, ListItem)? = nil) {
        // self.di = di
        self.route = route
        self.completion = completion
        self.itemToEdit = itemToEdit
    }

}

// MARK: - ListDetailVM

extension ListDetailViewModel: ListDetailVM {

    func setup(viewDelegate: ListDetailViewDelegate) {
        self.viewDelegate = viewDelegate
        if let itemToEdit = itemToEdit {
            // Preload Item to Edit and put page in edit mode
            self.viewDelegate?.preload(editItem: itemToEdit.1)
        }
    }
    
    func itemAddedOrEdited(titleName: String) {
        if let itemToEdit = itemToEdit {
            // Set the new name
            itemToEdit.1.title = titleName
            
            completion?(itemToEdit.1, itemToEdit.0)
        } else {
            completion?(ListItem(title: titleName), nil)
        }
    }

}

// MARK: - ListDetailTransition

extension ListDetailViewModel: ListDetailTransition {
    func goBack() {
        route?.popToPrevious()
    }
}

// MARK: - Private

extension ListDetailViewModel {

}
