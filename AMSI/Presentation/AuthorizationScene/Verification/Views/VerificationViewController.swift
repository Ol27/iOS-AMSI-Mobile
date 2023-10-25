//
//  VerificationViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import SnapKit
import UIKit

final class VerificationViewController: UIViewController {
    // MARK: - UI Elements

    private let imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.Images.Verification.verificationImage.image
    }

    private let verificationLabel = CustomStyleLabel(text: LocalizedStrings.verificationCode,
                                                     fontSize: 24,
                                                     isBold: true,
                                                     alignment: .center)

    private let infoLabel = CustomStyleLabel(text: LocalizedStrings.sendVerificationToEmail,
                                             fontSize: 14,
                                             fontColor: Assets.Colors.Shared.secondaryText.color,
                                             alignment: .center)

    private let emailLabel = CustomStyleLabel(fontSize: 14,
                                              isBold: true,
                                              alignment: .center)

    private let pinField = PinFieldTwo().apply {
        $0.font = UIFont.boldSystemFont(ofSize: 20)
        $0.activeBoxBackgroundColor = .clear
        $0.activeBorderColor = Assets.Colors.Shared.mainAccent.color
        $0.borderColor = .clear
        $0.boxBackgroundColor = Assets.Colors.Shared.textFieldBackground.color
        $0.filledBoxBackgroundColor = Assets.Colors.Shared.textFieldBackground.color
        $0.cornerRadius = 8
        $0.numberOfDigits = 4
        $0.spacing = 16
    }

    private let resendCodeButton = CustomStyleLabel(text: LocalizedStrings.resendCode,
                                                    fontSize: 14,
                                                    fontColor: Assets.Colors.Shared.mainAccent.color, isBold: true,
                                                    alignment: .center)

    private let verifyButton = FilledButton(text: LocalizedStrings.verifyButton)

    // MARK: - Properties

    private let verificationType: VerificationType
    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Initialization

    init(verificationType: VerificationType = .verify) {
        self.verificationType = verificationType
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCustomBackButton()
        setupKeyboardNotifications()
        setupSelectors()
        setupTitleLogo()
    }

    // MARK: - Actions

    @objc private func didTapVerifyButton() {
        switch verificationType {
        case .changePassword:
            coordinator?.navigateToChangePassword()
        case .verify:
            coordinator?.navigateToVerificationSuccess()
        }
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) { [self] in
            verifyButton.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(24)
                make.height.equalTo(56)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(keyboardFrame.height)
            }
            resendCodeButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(22)
                make.bottom.equalTo(verifyButton.snp.top).offset(-16)
            }
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }
        UIView.animate(withDuration: duration) { [self] in
            verifyButton.snp.remakeConstraints { make in
                make.left.right.equalToSuperview().inset(24)
                make.height.equalTo(56)
                make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            }
            resendCodeButton.snp.remakeConstraints { make in
                make.centerX.equalToSuperview()
                make.height.equalTo(22)
                make.bottom.equalTo(verifyButton.snp.top).offset(-120)
            }
            self.view.layoutIfNeeded()
        }
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        view.addSubview(verifyButton)
        verifyButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }

        view.addSubview(resendCodeButton)
        resendCodeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(verifyButton.snp.top).offset(-120)
        }

        view.addSubview(pinField)
        pinField.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
            make.width.equalTo(56 * 4 + 16 * 3)
            make.bottom.equalTo(resendCodeButton.snp.top).offset(-24)
        }

        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(22)
            make.bottom.equalTo(pinField.snp.top).offset(-32)
        }

        view.addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(22)
            make.bottom.equalTo(emailLabel.snp.top)
        }

        view.addSubview(verificationLabel)
        verificationLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(36)
            make.bottom.equalTo(infoLabel.snp.top).offset(-8)
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(verificationLabel.snp.top).offset(-8)
            make.left.right.equalToSuperview()
        }
    }

    private func setupSelectors() {
        verifyButton.addTarget(self, action: #selector(didTapVerifyButton), for: .touchUpInside)
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
