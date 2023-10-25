//
//  UIView+FadeInFeedback.swift
//  AMSI
//
//  Created by Anton Petrov on 24.10.2023.
//
import UIKit

extension UIView {
    func fadeInWithFeedback() {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
        alpha = 0.3
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}
