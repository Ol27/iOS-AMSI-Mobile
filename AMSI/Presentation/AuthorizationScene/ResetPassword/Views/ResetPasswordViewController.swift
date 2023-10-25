//
//  ResetPasswordViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 11.10.2023.
//

import SnapKit
import UIKit

final class ResetPasswordViewController: UIViewController {
    // MARK: - UI Elements

    private let titleLabel = CustomStyleLabel(text: LocalizedStrings.resetPasswordTitle,
                                              fontSize: 24,
                                              isBold: true,
                                              alignment: .left)

    private let infoLabel = CustomStyleLabel(text: LocalizedStrings.resetPasswordText,
                                             fontSize: 14,
                                             alignment: .left)

    private let inputContainerStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let passwordTextField = PasswordTextField()
    private let confirmPasswordTextField = PasswordTextField(placeholderText: LocalizedStrings.confirmPassword)

    private let createNewPasswordButton = FilledButton(text: LocalizedStrings.createNewPasswordButton)

    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Initialization

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

    @objc private func didTapSignUpButton() {
        coordinator?.navigateToChangePasswordSuccess()
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
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

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }

        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }

        view.addSubview(inputContainerStackView)
        inputContainerStackView.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }

        inputContainerStackView.addArrangedSubview(passwordTextField)
        inputContainerStackView.addArrangedSubview(confirmPasswordTextField)

        view.addSubview(createNewPasswordButton)
        setupBottomViews()
    }

    private func setupSelectors() {
        createNewPasswordButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
    }

    private func setupBottomViews() {
        createNewPasswordButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(56)
        }

        createNewPasswordButton.layoutIfNeeded()
    }

    private func liftBottomViews(keyboardHeight: CGFloat) {
        createNewPasswordButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(24)
        }
        createNewPasswordButton.layoutIfNeeded()
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
