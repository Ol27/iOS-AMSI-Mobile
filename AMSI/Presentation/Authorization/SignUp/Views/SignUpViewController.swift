//
//  SignUpViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import SnapKit
import UIKit

final class SignUpViewController: UIViewController {
    // MARK: - UI elements

    private let scrollView = UIScrollView().apply {
        $0.isScrollEnabled = false
    }

    private let contentView = UIView()
    private let titleLabel = CustomStyleLabel(text: LocalizedStrings.createAccount,
                                              fontSize: 20,
                                              isBold: true,
                                              alignment: .left)

    private let inputContainerStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let fullNameTextField = AuthorizationTextField(placeholderText: LocalizedStrings.fullName,
                                                           icon: Assets.Images.SignUp.fullNameIcon.image)
    private let emailTextField = AuthorizationTextField(placeholderText: LocalizedStrings.email,
                                                        icon: Assets.Images.SignUp.emailIcon.image)

    private let passwordTextField = PasswordTextField()

    private let signUpButton = FilledButton(text: LocalizedStrings.signUpButton)

    private let googleButton = GoogleButton(text: LocalizedStrings.signInWithGoogle)

    private let separator = CustomStyleSeparator()

    // MARK: - Properties

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

    @objc private func didTapSignUpButton() {
        coordinator?.signIn()
    }

    @objc private func didTapGoogleButton() {
        coordinator?.signIn()
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let visibleAreaHeight = view.frame.height - keyboardFrame.height
        let contentEndY = signUpButton.frame.origin.y + signUpButton.frame.height + googleButton.frame.height + separator.frame.height
        if contentEndY > visibleAreaHeight {
            let scrollPoint = CGPoint(x: 0, y: contentEndY - visibleAreaHeight)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            self.scrollView.contentOffset = CGPoint(x: 0, y: 64)
            self.liftBottomViews(keyboardHeight: keyboardFrame.height)
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) {
            self.setupBottomViews()
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.addSubview(contentView)

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }

        contentView.addSubview(inputContainerStackView)
        inputContainerStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }

        inputContainerStackView.addArrangedSubview(fullNameTextField)
        inputContainerStackView.addArrangedSubview(emailTextField)
        inputContainerStackView.addArrangedSubview(passwordTextField)

        contentView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(inputContainerStackView.snp.bottom).offset(32)
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
        }
        contentView.addSubview(googleButton)
        contentView.addSubview(separator)
        setupBottomViews()
    }

    private func setupSelectors() {
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
    }

    private func setupBottomViews() {
        contentView.snp.remakeConstraints { make in
            make.width.height.equalTo(view.safeAreaLayoutGuide)
            make.edges.equalToSuperview()
        }

        googleButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(12)
            make.height.equalTo(56)
        }

        separator.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(googleButton.snp.top).offset(-12)
        }
        separator.layoutIfNeeded()
        googleButton.layoutIfNeeded()
    }

    private func liftBottomViews(keyboardHeight: CGFloat) {
        contentView.snp.remakeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.frame.height - keyboardHeight + 52)
            make.edges.equalToSuperview()
        }
        separator.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(signUpButton.snp.bottom).offset(24)
        }
        googleButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.top.equalTo(separator.snp.bottom).offset(24)
        }
        separator.layoutIfNeeded()
        googleButton.layoutIfNeeded()
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
