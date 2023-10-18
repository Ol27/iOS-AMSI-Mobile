//
//  MainTabBarCoordinator.swift
//  AMSI
//
//  Created by Anton Petrov on 17.10.2023.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
}

final class TabCoordinator: TabCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var type: CoordinatorType { .mainTabs }

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = MainTabBarController()
    }

    func start() {
        let controllers = TabItem.allCases.map { UINavigationController(rootViewController: $0.rootViewController) }
        tabBarController.setViewControllers(controllers, animated: true)
        tabBarController.selectedIndex = 0
        navigationController.pushViewController(tabBarController, animated: true)
        guard !SettingsManager.shared.didFilledData else { return }
        let fillDataVC = FillDataViewController()
        fillDataVC.coordinator = self
        let fillDataNavigationVC = UINavigationController(rootViewController: fillDataVC)
        fillDataNavigationVC.modalPresentationStyle = .overFullScreen
        navigationController.present(fillDataNavigationVC, animated: true, completion: nil)
    }
}
