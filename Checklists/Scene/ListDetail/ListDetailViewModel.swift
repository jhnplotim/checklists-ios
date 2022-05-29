// 
//  ListDetailViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 28.05.22.
//

import Foundation

typealias AddOrEditCheckList = ((ListRowView.Model, Int?) -> Void)

protocol ListDetailVM: AnyObject {
    func setup(viewDelegate: ListDetailViewDelegate)
    func itemAddedOrEdited(titleName: String)
}

protocol ListDetailTransition: AnyObject {
    func goBack()
}

final class ListDetailViewModel {

    // typealias DI = AnyObject

    private weak var route: AppRoute?
    private weak var viewDelegate: ListDetailViewDelegate?

    // private var di: DI
    private var completion: AddOrEditCheckList?
    private var itemToEdit: (Int, ListRowView.Model)?

    // MARK: - Constructor

    init(route: AppRoute? = nil, completion: AddOrEditCheckList? = nil, itemToEdit: (Int, ListRowView.Model)? = nil) {
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
            completion?(ListRowView.Model(title: titleName), itemToEdit.0)
        } else {
            completion?(ListRowView.Model(title: titleName), nil)
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
