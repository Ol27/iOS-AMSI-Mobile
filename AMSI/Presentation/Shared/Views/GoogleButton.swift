//
//  GoogleButton.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import SnapKit
import UIKit

final class GoogleButton: UIButton {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = Fonts.NotoSansJP.medium.font(size: 14)
        label.textAlignment = .center
        label.textColor = Assets.Colors.Shared.mainText.color
        return label
    }()

    init(text: String, icon: UIImage? = Assets.Images.Authorization.googleLogo.image) {
        super.init(frame: .zero)
        iconImageView.image = icon
        label.text = text
        isUserInteractionEnabled = false
        addSubview(iconImageView)
        addSubview(label)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        layer.borderWidth = 1.0
        layer.borderColor = Assets.Colors.Shared.separator.color.cgColor
        layer.cornerRadius = 8
        iconImageView.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-54)
        }
    }
}
