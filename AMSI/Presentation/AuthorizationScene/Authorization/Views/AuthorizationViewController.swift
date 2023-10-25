//
//  AuthorizationViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    // MARK: - UI Elements

    private let logoImageView = UIImageView().apply {
        $0.image = Assets.Images.Authorization.amsiLogo.image
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = CustomStyleLabel(text: LocalizedStrings.welcomeTitle,
                                              fontSize: 20,
                                              isBold: true,
                                              alignment: .center)
    private let subtitleLabel = CustomStyleLabel(text: LocalizedStrings.welcomeText,
                                                 fontSize: 16,
                                                 fontColor: Assets.Colors.Shared.secondaryText.color,
                                                 alignment: .center,
                                                 numberOfLines: 0)
    private let pictureImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.Images.Authorization.authorizationImage.image
    }

    private let emailButton = FilledButton(text: LocalizedStrings.emailButton)
    private let googleButton = GoogleButton(text: LocalizedStrings.continueWithGoogleButton)
    private lazy var signUpButton = UIButton().apply {
        $0.setAttributedTitle(createAttributedText(), for: .normal)
    }

    // MARK: - Properties

    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSelectors()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Actions

    @objc private func didTapSignUpButton() {
        coordinator?.navigateToSignUp()
    }

    @objc private func didTapEmailButton() {
        coordinator?.navigateToLogin()
    }

    @objc private func didTapGoogleButton() {
        coordinator?.signIn()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        navigationItem.titleView = logoImageView
        navigationItem.hidesBackButton = true

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }

        view.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(22)
        }

        view.addSubview(googleButton)
        googleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(signUpButton.snp.top).offset(-98)
            make.height.equalTo(56)
        }

        view.addSubview(emailButton)
        emailButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(googleButton.snp.top).inset(-12)
            make.height.equalTo(56)
        }

        view.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(emailButton.snp.top).inset(-31)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(14)
        }
    }

    private func setupSelectors() {
        signUpButton.addTarget(self, action: #selector(didTapSignUpButton), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(didTapEmailButton), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(didTapGoogleButton), for: .touchUpInside)
    }

    // MARK: - Helpers

    private func createAttributedText() -> NSAttributedString {
        let firstText = LocalizedStrings.dontHaveAccountText
        let firstAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: Fonts.NotoSansJP.regular.font(size: 14)
        ]
        let firstAttributedString = NSMutableAttributedString(string: firstText, attributes: firstAttributes)
        let secondText = LocalizedStrings.signUpButton
        let secondAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: Fonts.NotoSansJP.bold.font(size: 14)
        ]
        let secondAttributedString = NSMutableAttributedString(string: secondText, attributes: secondAttributes)
        firstAttributedString.append(secondAttributedString)
        return firstAttributedString
    }
}
