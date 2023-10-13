//
//  PasswordTextField.swift
//  AMSI
//
//  Created by Anton Petrov on 11.10.2023.
//

import SnapKit
import UIKit

final class PasswordTextField: UIView {
    let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = Assets.Colors.Shared.mainText.color
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.smartQuotesType = .no
        textField.returnKeyType = .done
        textField.textContentType = .none
        textField.isSecureTextEntry = true
        textField.font = Fonts.NotoSansJP.regular.font(size: 14)
        return textField
    }()

    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.Colors.Shared.textFieldBackground.color
        view.layer.cornerRadius = 8
        return view
    }()

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let showPasswordButton = UIButton().apply {
        $0.setImage(Assets.Images.SignUp.showPasswordButton.image, for: .normal)
    }

    init(placeholderText: String = LocalizedStrings.password,
         icon: UIImage? = Assets.Images.SignUp.paswordIcon.image) {
        super.init(frame: .zero)

        let attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [
                .font: Fonts.NotoSansJP.regular.font(size: 14),
                .foregroundColor: Assets.Colors.Shared.mainText.color
            ]
        )

        textField.attributedPlaceholder = attributedPlaceholder
        iconImageView.image = icon
        addSubview(backgroundView)
        backgroundView.addSubview(iconImageView)
        backgroundView.addSubview(showPasswordButton)
        backgroundView.addSubview(textField)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapShowPassword() {
        textField.isSecureTextEntry.toggle()
        let image = textField.isSecureTextEntry
            ? Assets.Images.SignUp.showPasswordButton.image
            : Assets.Images.SignUp.hidePasswordButton.image
        showPasswordButton.setImage(image, for: .normal)
    }

    private func setupUI() {
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }

        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }

        showPasswordButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
        }
        showPasswordButton.addTarget(self, action: #selector(didTapShowPassword), for: .touchUpInside)

        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.equalTo(showPasswordButton.snp.left).inset(-12)
            make.top.bottom.equalToSuperview()
        }
        textField.delegate = self
    }
}

extension PasswordTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1.0
        layer.borderColor = Assets.Colors.Shared.mainAccent.color.cgColor
        layer.cornerRadius = 8.0
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        layer.borderWidth = 0.0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
