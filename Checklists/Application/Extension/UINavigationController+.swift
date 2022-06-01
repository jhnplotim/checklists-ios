//
//  UINavigationController+.swift
//  Checklists
//
//  Created by John Paul Otim on 01.06.22.
//

import Foundation

import UIKit

extension UINavigationController {
    
    static var customNavigationController: CustomUINavigationViewController {
        return CustomUINavigationViewController.create(viewModel: CustomUINavigationViewModel())
    }
    
}
