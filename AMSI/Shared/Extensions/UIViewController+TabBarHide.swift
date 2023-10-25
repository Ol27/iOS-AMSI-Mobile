//
//  UIViewController+TabBarHide.swift
//  AMSI
//
//  Created by Anton Petrov on 25.10.2023.
//

import UIKit

extension UIViewController {
    func hideCustomTabBar() {
        (tabBarController as? MainTabBarController)?.hideTabBar()
    }

    func showCustomTabBar() {
        (tabBarController as? MainTabBarController)?.showTabBar()
    }
}
