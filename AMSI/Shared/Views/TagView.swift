//
//  TagView.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import SnapKit
import UIKit

final class TagView: UIView {
    private let typeTag = CustomStyleLabel(fontSize: 12).apply {
        $0.clipsToBounds = true
    }

    var text: String? {
        didSet {
            typeTag.text = text
        }
    }

    init(backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        layer.cornerRadius = 4
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(typeTag)
        typeTag.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8))
        }
    }
}
