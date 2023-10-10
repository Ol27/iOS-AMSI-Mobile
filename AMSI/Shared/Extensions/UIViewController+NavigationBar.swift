//
//  UIViewController+NavigationBar.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

extension UIViewController {
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
