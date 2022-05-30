// 
//  IconPickerViewModel.swift
//  Checklists
//
//  Created by John Paul Otim on 30.05.22.
//

import Foundation

typealias IconNameCompletionClosure = ((String) -> Void)

protocol IconPickerVM: AnyObject {
    func setup(viewDelegate: IconPickerViewDelegate)
    func iconSelected(_ iconName: String)
}

protocol IconPickerTransition: AnyObject {

}

final class IconPickerViewModel {

    private weak var route: ChecklistRoute?
    private weak var viewDelegate: IconPickerViewDelegate?
    private var completion: IconNameCompletionClosure?

    // MARK: - Constructor

    init(route: ChecklistRoute? = nil, completion: @escaping IconNameCompletionClosure) {
        self.route = route
        self.completion = completion
    }

}

// MARK: - IconPickerVM

extension IconPickerViewModel: IconPickerVM {

    func setup(viewDelegate: IconPickerViewDelegate) {
        self.viewDelegate = viewDelegate
    }
    
    func iconSelected(_ iconName: String) {
        completion?(iconName)
        route?.popToPrevious()
    }

}

// MARK: - IconPickerTransition

extension IconPickerViewModel: IconPickerTransition {
    
}

// MARK: - Private

extension IconPickerViewModel {

}
