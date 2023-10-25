//
//  UIViewController+TabBarHide.swift
//  AMSI
//
//  Created by Anton Petrov on 25.10.2023.
//

import UIKit

extension UIViewController {
    func hideCustomTabBar() {
        (self.tabBarController as? MainTabBarController)?.hideTabBar()
    }

    func showCustomTabBar() {
        (self.tabBarController as? MainTabBarController)?.showTabBar()
    }
}
