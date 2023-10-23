//
//  AuthCoordinator.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

protocol AuthCoordinatorProtocol: Coordinator {
    func navigateToAuthorization()
    func navigateToOnboarding()
    func navigateToLogin()
    func popToLogin()
    func navigateToSignUp()
    func navigateToVerification()
    func navigateToVerificationSuccess()
    func navigateToChangePasswordVerification()
    func navigateToChangePasswordSuccess()
    func navigateToChangePassword()
    func navigateToForgotPassword()
    func signIn()
    func dismissOnboarding()
}

final class AuthCoordinator: AuthCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .authorization }

    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let splashViewController = SplashViewController()
        splashViewController.coordinator = self
        navigationController.viewControllers = [splashViewController]
    }

    func navigateToAuthorization() {
        let authVC = AuthorizationViewController()
        authVC.coordinator = self
        navigationController.pushViewController(authVC, animated: true)
        navigateToOnboarding()
    }

    func navigateToOnboarding() {
//        guard !SettingsManager.shared.didShowOnboarding else { return }
        let onboardingVC = OnboardingViewController()
        onboardingVC.coordinator = self
        onboardingVC.modalPresentationStyle = .overFullScreen
        navigationController.present(onboardingVC, animated: true, completion: nil)
    }

    func navigateToLogin() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(loginVC, animated: true)
    }

    func dismissOnboarding() {
        navigationController.dismiss(animated: true) {
            SettingsManager.shared.didShowOnboarding = true
        }
    }

    func navigateToSignUp() {
        let signUpVC = SignUpViewController()
        signUpVC.coordinator = self
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(signUpVC, animated: true)
    }

    func navigateToVerification() {
        let verificationVC = VerificationViewController()
        verificationVC.coordinator = self
        navigationController.pushViewController(verificationVC, animated: true)
    }

    func navigateToVerificationSuccess() {
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
        let child = TabCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.start()
    }

    func navigateToForgotPassword() {
        let successVC = ForgotPasswordViewController()
        successVC.coordinator = self
        navigationController.pushViewController(successVC, animated: true)
    }

    func navigateToChangePasswordVerification() {
        let verificationVC = VerificationViewController(verificationType: .changePassword)
        verificationVC.coordinator = self
        navigationController.pushViewController(verificationVC, animated: true)
    }

    func navigateToChangePasswordSuccess() {
        let successVC = SuccessViewController(successType: .changePassword)
        successVC.coordinator = self
        navigationController.pushViewController(successVC, animated: true)
    }

    func navigateToChangePassword() {
        let passwordVC = ResetPasswordViewController()
        passwordVC.coordinator = self
        navigationController.pushViewController(passwordVC, animated: true)
    }
}
