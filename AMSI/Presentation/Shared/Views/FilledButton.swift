//
//  FilledButton.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import SnapKit
import UIKit

final class FilledButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)

        setTitle(text, for: .normal)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        backgroundColor = Assets.Colors.Shared.mainAccent.color
        setTitleColor(Assets.Colors.Shared.filledButtonText.color, for: .normal)
        titleLabel?.font = Fonts.NotoSansJP.bold.font(size: 14)
        layer.cornerRadius = 8
        snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}
