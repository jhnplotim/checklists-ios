// 
//  RootCoordinator.swift
//  Checklists
//
//  Created by Otim John Paul on 25.05.22.
//

import UIKit
import Combine

// MARK: - Router Interface

protocol RootRoute: AnyObject {

}

final class RootCoordinator: Coordinator {
    
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    private let applicationWindow: UIWindow
    
    private var cancellables = Set<AnyCancellable>()
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.parentCoordinator = nil
        self.applicationWindow = window
        
        window.rootViewController = navigationController
        window.backgroundColor = .black
        window.makeKeyAndVisible()
    }
    
    func start() {
        let appCoordinator = AppCoordinator(navigationController: UINavigationController(), parentCoordinator: self)
        appCoordinator.start()
        childCoordinators.append(appCoordinator)
        
        // TODO: Switch between Unauthenticated and authenticated workflows later
        // Set AppCoordinator as the root coordinator
        Animator.setRootViewController(appCoordinator.coordinatorStartController, window: applicationWindow)
    }
    
}

// MARK: - Router implementation

extension RootCoordinator: RootRoute {
    
}

// MARK: - Private

extension RootCoordinator {

}
