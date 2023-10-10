//
//   SuccessViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 10.10.2023.
//

import SnapKit
import UIKit

final class SuccessViewController: UIViewController {
    private let imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.Images.Success.successImage.image
    }
    private let successLabel = CustomStyleLabel(fontSize: 20,
                                                isBold: true,
                                                alignment: .center,
                                                numberOfLines: 0)

    private let loginButton = FilledButton(text: LocalizedStrings.loginButton)

    enum SuccessType {
        case changePassword
        case verify
    }
    weak var coordinator: Coordinator?

    init(successType: SuccessType) {
        super.init(nibName: nil, bundle: nil)
        switch successType {
        case .changePassword:
            successLabel.text = LocalizedStrings.changePasswordSuccess
        case .verify:
            successLabel.text = LocalizedStrings.verifySuccess
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSelectors()
        setupBackButton()
    }

    @objc private func didTapLoginButton() {
        coordinator?.popToLogin()
    }

    func setupBackButton() {
        let image = Assets.Images.Success.crossBackButton.image.withRenderingMode(.alwaysOriginal)
        let backButton = UIBarButtonItem(image: image,
                                         style: .plain,
                                         target: self,
                                         action: #selector(self.didTapBackButton))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                           style: .plain,
                                                           target: nil,
                                                           action: nil)
        navigationItem.leftBarButtonItem = backButton
    }

    @objc private func didTapBackButton() {
        coordinator?.popToLogin()
    }

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color

        view.addSubview(successLabel)
        successLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.center.equalToSuperview()
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(182)
            make.bottom.equalTo(successLabel.snp.top).offset(-28)
        }

        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
    }

    private func setupSelectors() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
    }
}
