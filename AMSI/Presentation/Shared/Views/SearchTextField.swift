//
//  SearchTextField.swift
//  AMSI
//
//  Created by Anton Petrov on 25.10.2023.
//

import SnapKit
import UIKit

final class SearchTextField: UITextField {
    private let padding = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 0)

    init(placeholderText: String,
         placeholderFont: UIFont = Fonts.NotoSansJP.regular.font(size: 16),
         placeholderColor: UIColor = Assets.Colors.Shared.lightGrayText.color,
         textFont: UIFont = Fonts.NotoSansJP.regular.font(size: 16),
         textColor: UIColor = Assets.Colors.Shared.mainText.color) {
        super.init(frame: .zero)
        backgroundColor = Assets.Colors.Shared.screenBackground.color
        layer.borderColor = Assets.Colors.Shared.border.color.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 16
        autocorrectionType = .no
        autocapitalizationType = .none
        spellCheckingType = .no
        smartQuotesType = .no
        returnKeyType = .done
        textContentType = .none
        font = textFont
        self.textColor = textColor
        attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                   attributes: [NSAttributedString.Key.foregroundColor: placeholderColor,
                                                                NSAttributedString.Key.font: placeholderFont])
        let magnifyingImageView = UIImageView(image: Assets.Images.Shared.searchGlass.image)
        magnifyingImageView.contentMode = .scaleAspectFit
        addSubview(magnifyingImageView)
        magnifyingImageView.snp.makeConstraints { make in
            make.left.equalTo(self).offset(14)
            make.centerY.equalTo(self)
            make.width.height.equalTo(20)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
