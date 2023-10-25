//
//  SmallActionButton.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import SnapKit
import UIKit

final class SmallActionButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)
        setTitle(text, for: .normal)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        backgroundColor = Assets.Colors.Shared.actionButtonBackground.color
        layer.cornerRadius = 8
        titleLabel?.font = Fonts.NotoSansJP.medium.font(size: 12)
        setTitleColor(Assets.Colors.Shared.mainAccent.color, for: .normal)
        snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(32)
        }
    }
}
