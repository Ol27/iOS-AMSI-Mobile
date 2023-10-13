//
//  AddressDataCell.swift
//  AMSI
//
//  Created by Anton Petrov on 12.10.2023.
//

import UIKit

final class AddressDataCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = Assets.Colors.Shared.mainText.color
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        textField.smartQuotesType = .no
        textField.returnKeyType = .done
        textField.textContentType = .none
        textField.font = Fonts.NotoSansJP.regular.font(size: 14)
        return textField
    }()

    private let iconImageView = UIImageView().apply {
        $0.image = Assets.Images.Shared.pickArrow.image
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }

    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.Colors.Shared.textFieldBackground.color
        view.layer.cornerRadius = 8
        return view
    }()

    // MARK: - Properties

    private let iconImageViewSideSize: CGFloat = 24
    private lazy var cellInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private lazy var contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
        textField.delegate = self
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(withData addressData: AddressData, text: String?) {
        let attributedPlaceholder = NSAttributedString(
            string: addressData.placeholder,
            attributes: [
                .font: Fonts.NotoSansJP.regular.font(size: 14),
                .foregroundColor: Assets.Colors.Shared.mainText.color
            ]
        )
        textField.text = text
        textField.attributedPlaceholder = attributedPlaceholder
        textField.isUserInteractionEnabled = !addressData.shouldBePicked
        iconImageView.isHidden = !addressData.shouldBePicked
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview()
        }

        backgroundContainerView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }
        textField.delegate = self

        backgroundContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
        }
    }
}

extension AddressDataCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        backgroundContainerView.layer.borderWidth = 1.0
        backgroundContainerView.layer.borderColor = Assets.Colors.Shared.mainAccent.color.cgColor
        backgroundContainerView.layer.cornerRadius = 8.0
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        backgroundContainerView.layer.borderWidth = 0.0
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
