//
//  UIViewController+BlurLoader.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import UIKit

extension UIViewController {
    private var blurEffectViewTag: Int { 1001 }
    private var activityIndicatorTag: Int { 1002 }

    func showActivityIndicator(withBlurEffect style: UIBlurEffect.Style = .regular) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = blurEffectViewTag
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.tag = activityIndicatorTag
        blurEffectView.contentView.addSubview(activityIndicator)
        view.addSubview(blurEffectView)
    }

    func hideActivityIndicator() {
        view.viewWithTag(activityIndicatorTag)?.removeFromSuperview()
        view.viewWithTag(blurEffectViewTag)?.removeFromSuperview()
    }
}
