//
//  SplashViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import SnapKit
import UIKit

final class SplashViewController: UIViewController {
    private let logoImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.Images.Splash.splashLogo.image
    }

    weak var coordinator: Coordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startFloatingAnimation()
        navigateToOnboardingAfterDelay()
    }

    private func startFloatingAnimation() {
        UIView.animate(withDuration: 1.5, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -20)
        }, completion: nil)
    }

    private func navigateToOnboardingAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.coordinator?.setupMainNavigationFlow()
        }
    }

    private func setupUI() {
        view.backgroundColor = Assets.Colors.splashScreen.color
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(208)
        }
    }
}
