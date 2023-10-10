//
//  FilledButton.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit
import SnapKit

final class FilledButton: UIButton {
    init(text: String) {
        super.init(frame: .zero)

        setTitle(text, for: .normal)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup

    private func setupUI() {
        self.backgroundColor = Assets.Colors.Shared.mainAccent.color
        self.setTitleColor(Assets.Colors.Shared.filledButtonText.color, for: .normal)
        self.titleLabel?.font = Fonts.NotoSansJP.bold.font(size: 14)
        self.layer.cornerRadius = 8
        self.snp.makeConstraints { (make) in
            make.height.equalTo(56)
        }
    }
}
