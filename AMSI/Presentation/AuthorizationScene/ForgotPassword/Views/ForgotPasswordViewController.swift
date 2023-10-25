//
//  ForgotPasswordViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 11.10.2023.
//

import SnapKit
import UIKit

final class ForgotPasswordViewController: UIViewController {
    // MARK: - UI elements

    private let imageView = UIImageView().apply {
        $0.image = Assets.Images.ForgotPassword.forgotPassword.image
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = CustomStyleLabel(text: LocalizedStrings.forgotPassword,
                                              fontSize: 24,
                                              isBold: true,
                                              alignment: .center)

    private let infoLabel = CustomStyleLabel(text: LocalizedStrings.forgotPasswordText,
                                             fontSize: 14,
                                             alignment: .center,
                                             numberOfLines: 0)

    private let emailTextField = AuthorizationTextField(placeholderText: LocalizedStrings.email,
                                                        icon: Assets.Images.SignUp.emailIcon.image)

    private let sendEmailButton = FilledButton(text: LocalizedStrings.sendMeEmailButton)

    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Lifecycle

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCustomBackButton()
        setupTitleLogo()
        setupKeyboardNotifications()
        setupSelectors()
        setupNavigationBar()
    }

    // MARK: - Actions

    @objc private func didTapSendMeEmail() {
        coordinator?.navigateToChangePasswordVerification()
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            self.liftBottomViews(keyboardHeight: keyboardFrame.height)
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            self.setupBottomViews()
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Setup

    private func setupBottomViews() {
        view.addSubview(sendEmailButton)
        sendEmailButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-98)
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
        }
    }

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color

        setupBottomViews()

        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.bottom.equalTo(sendEmailButton.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(24)
        }

        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(emailTextField.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(44)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(infoLabel.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(34)
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(62)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(42)
        }
    }

    private func setupSelectors() {
        sendEmailButton.addTarget(self, action: #selector(didTapSendMeEmail), for: .touchUpInside)
    }

    private func liftBottomViews(keyboardHeight: CGFloat) {
        sendEmailButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-(keyboardHeight + 8))
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
        }
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
