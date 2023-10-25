//
//  UIViewController+SafeAreaHeight.swift
//  AMSI
//
//  Created by Anton Petrov on 25.10.2023.
//

import UIKit

extension UIViewController {
    var safeAreaBottomHeight: CGFloat {
        view.safeAreaInsets.bottom + 16
    }
}
