//
//  CustomStyleSeparator.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import SnapKit
import UIKit

final class CustomStyleSeparator: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.Images.Shared.orSeparator.image
        return imageView
    }()

    private let label = CustomStyleLabel(text: LocalizedStrings.orSeparator,
                                         fontSize: 14,
                                         fontColor: Assets.Colors.Shared.secondaryText.color,
                                         alignment: .center)

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(imageView)
        addSubview(label)

        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        snp.makeConstraints { make in
            make.height.equalTo(22)
        }
    }
}
