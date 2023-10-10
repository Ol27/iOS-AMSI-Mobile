//
//  UIViewController+BackButton.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

extension UIViewController {
    func setupCustomBackButton() {
        let image = Assets.Images.Shared.backButton.image.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: image,
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.didTapCustomBackButton))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func didTapCustomBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
