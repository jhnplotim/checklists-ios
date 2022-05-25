//
//  Coordinator.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit

protocol Coordinator: AnyObject {
    var parentCoordinator: Coordinator? { get }
    
    var childCoordinators: [Coordinator] { get set }
    
    var navigationController: UINavigationController { get set }
    var coordinatorStartController: UIViewController { get }
    
    /// Defines the Root controller
    ///
    /// Each coordinator should have initialized starter Conroller which will be the first in the stack in Navigation Controller, or user specified main controller (example: TabBar)
    ///
    func start()
    
    /// Used for close certain flow connected with coordinator. It forces the parent coordinator to also delete the reference
    func finish()
    
}



extension Coordinator {
    
    var coordinatorStartController: UIViewController {
        return navigationController
    }
    
    func finish() {
        parentCoordinator?.childCoordinators.enumerated().forEach { [weak self] (index, coordinator) in
            if coordinator === self {
                parentCoordinator?.childCoordinators.remove(at: index)
            }
        }
    }
    
}

    // MARK: - Navigation Controller Operations

extension Coordinator {
    
    func setRoot(_ controller: UIViewController, animated: Bool = true) {
        navigationController.setViewControllers([controller], animated: animated)
    }
    
    func push(_ controller: UIViewController, animated: Bool = true) {
        navigationController.pushViewController(controller, animated: animated)
    }
    
    func present(_ controller: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.present(controller, animated: animated, completion: completion)
    }
    
    func pop(to controller: UIViewController, animated: Bool = true) {
        navigationController.popToViewController(controller, animated: animated)
    }
    
    func popToRoot(animated: Bool) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController.dismiss(animated: animated, completion: completion)
    }
    
}
