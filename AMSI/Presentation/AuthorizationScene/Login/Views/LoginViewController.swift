//
//  LoginViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 10.10.2023.
//

import SnapKit
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - UI Elements

    private let scrollView = UIScrollView().apply {
        $0.isScrollEnabled = false
    }

    private let contentView = UIView()
    private let imageView = UIImageView().apply {
        $0.image = Assets.Images.Login.loginImage.image
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = CustomStyleLabel(text: LocalizedStrings.loginTitle,
                                              fontSize: 24,
                                              isBold: true,
                                              alignment: .center)

    private let inputContainerStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 16
    }

    private let emailTextField = AuthorizationTextField(placeholderText: LocalizedStrings.email,
                                                        icon: Assets.Images.SignUp.emailIcon.image)

    private let passwordTextField = PasswordTextField()

    private let forgotPasswordLabel = CustomStyleLabel(text: LocalizedStrings.forgotPassword,
                                                       fontSize: 14,
                                                       isBold: true,
                                                       alignment: .right)

    private let signIn = FilledButton(text: LocalizedStrings.signInButton)

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

    @objc private func didTapSignInButton() {
        coordinator?.signIn()
    }

    @objc private func didTapForgotPassword() {
        coordinator?.navigateToForgotPassword()
    }

    @objc private func didTapGoogleButton() {
        coordinator?.signIn()
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let visibleAreaHeight = view.frame.height - keyboardFrame.height
        let contentEndY = signIn.frame.origin.y + signIn.frame.height + googleButton.frame.height + separator.frame.height
        if contentEndY > visibleAreaHeight {
            let scrollPoint = CGPoint(x: 0, y: contentEndY - visibleAreaHeight)
            scrollView.setContentOffset(scrollPoint, animated: true)
        }
        scrollView.isScrollEnabled = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.isScrollEnabled = false
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.addSubview(contentView)
        contentView.snp.remakeConstraints { make in
            make.width.height.equalTo(view.safeAreaLayoutGuide)
            make.edges.equalToSuperview()
        }

        contentView.addSubview(googleButton)
        googleButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }

        contentView.addSubview(separator)
        separator.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(22)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(googleButton.snp.top).offset(-12)
        }

        contentView.addSubview(signIn)
        signIn.snp.makeConstraints { make in
            make.bottom.equalTo(separator.snp.top).offset(-32)
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(24)
        }

        contentView.addSubview(forgotPasswordLabel)
        forgotPasswordLabel.snp.makeConstraints { make in
            make.bottom.equalTo(signIn.snp.top).offset(-22)
            make.height.equalTo(22)
            make.left.right.equalToSuperview().inset(24)
        }

        contentView.addSubview(inputContainerStackView)
        inputContainerStackView.snp.makeConstraints { make in
            make.bottom.equalTo(forgotPasswordLabel.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(24)
        }

        inputContainerStackView.addArrangedSubview(emailTextField)
        inputContainerStackView.addArrangedSubview(passwordTextField)

        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(inputContainerStackView.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(34)
        }

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-24)
            make.left.right.equalToSuperview().inset(62)
            make.top.equalToSuperview()
        }
    }

    private func setupSelectors() {
        signIn.addTarget(self, action: #selector(didTapSignInButton), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapForgotPassword))
        forgotPasswordLabel.isUserInteractionEnabled = true
        forgotPasswordLabel.addGestureRecognizer(tapGesture)
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
            make.top.equalTo(signIn.snp.bottom).offset(24)
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
