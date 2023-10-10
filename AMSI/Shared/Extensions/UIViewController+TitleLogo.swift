//
//  UIViewController+TitleLogo.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

extension UIViewController {
    func setupTitleLogo() {
         let logoImageView = UIImageView().apply {
            $0.image = Assets.Images.Authorization.amsiLogo.image
            $0.contentMode = .scaleAspectFit
        }
        navigationItem.titleView = logoImageView
    }
}
