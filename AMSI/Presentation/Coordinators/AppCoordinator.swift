//
//  AppCoordinator.swift
//  AMSI
//
//  Created by Anton Petrov on 17.10.2023.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showLoginFlow()
    func showMainFlow()
}

final class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?

    var navigationController: UINavigationController

    var childCoordinators = [Coordinator]()

    var type: CoordinatorType { .app }

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        showLoginFlow()
    }

    func showLoginFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        authCoordinator.finishDelegate = self
        authCoordinator.start()
        childCoordinators.append(authCoordinator)
    }

    func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController: navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0.type != childCoordinator.type }
        switch childCoordinator.type {
        case .mainTabs:
            navigationController.viewControllers.removeAll()
            showLoginFlow()
        case .authorization:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        default:
            break
        }
    }
}
