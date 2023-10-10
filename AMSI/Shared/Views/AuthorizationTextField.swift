//
//  AuthorizationTextField.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit
import SnapKit

final class AuthorizationTextField: UIView {
    let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = Assets.Colors.Shared.mainText.color
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.smartQuotesType = .no
        textField.returnKeyType = .done
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

    init(placeholderText: String, icon: UIImage?) {
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
        backgroundView.addSubview(textField)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.right.equalToSuperview()
            make.top.bottom.equalToSuperview()
        }
        textField.delegate = self
    }
}

extension AuthorizationTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderWidth = 1.0
        layer.borderColor = Assets.Colors.Shared.mainAccent.color.cgColor
        layer.cornerRadius = 8.0
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text?.isEmpty ?? true {
            layer.borderWidth = 0.0
        }
    }
}
