//
//  Coordinator.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    func start()
    func setupMainNavigationFlow()
    func navigateToOnboarding()
    func navigateToLogin()
    func popToLogin()
    func navigateToSignUp()
    func navigateToVerification()
    func navigateToVerificationSucess()
    func signIn()
    func dismissOnboarding()
}

final class MainCoordinator: Coordinator {
    var window: UIWindow?
    var navigationController: UINavigationController = UINavigationController()

    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        let splashViewController = SplashViewController()
         splashViewController.coordinator = self
         window?.rootViewController = splashViewController
         window?.makeKeyAndVisible()
    }

    func setupMainNavigationFlow() {
        let authVC = AuthorizationViewController()
        authVC.coordinator = self
        navigationController.viewControllers = [authVC]
        window?.rootViewController = navigationController
    }

    func navigateToOnboarding() {
        let onboardingVC = OnboardingViewController()
        onboardingVC.coordinator = self
        onboardingVC.modalPresentationStyle = .overFullScreen
        navigationController.present(onboardingVC, animated: true, completion: nil)
    }

    func navigateToLogin() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }

    func dismissOnboarding() {
        navigationController.dismiss(animated: true, completion: nil)
    }

    func navigateToSignUp() {
        let signUpVC = SignUpViewController()
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }

    func navigateToVerification() {
        let verificationVC = VerificationViewController()
        verificationVC.coordinator = self
        navigationController.pushViewController(verificationVC, animated: true)
    }

    func navigateToVerificationSucess() {
        let successVC = SuccessViewController(successType: .verify)
        successVC.coordinator = self
        navigationController.pushViewController(successVC, animated: true)
    }

    func popToLogin() {
        for controller in navigationController.viewControllers {
            if let authVC = controller as? AuthorizationViewController {
                navigationController.popToViewController(authVC, animated: true)
                let logincVC = LoginViewController()
                logincVC.coordinator = self
                navigationController.pushViewController(logincVC, animated: true)
                break
            }
        }
    }

    func signIn() {
        let verificationVC = MainTabViewController()
        navigationController.pushViewController(verificationVC, animated: true)
    }
}
