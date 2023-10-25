//
//  EventMarkerView.swift
//  AMSI
//
//  Created by Anton Petrov on 25.10.2023.
//

import SnapKit
import UIKit

final class EventMarkerView: UIImageView {
    private let roundImageView = UIImageView()

    init(roundImage: UIImage?) {
        super.init(frame: CGRect(x: 0, y: 0, width: 58, height: 64))
        image = Assets.Images.Events.eventMarker.image
        setupView()
        roundImageView.image = roundImage
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(roundImageView)
        roundImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview().inset(5)
            make.width.equalTo(roundImageView.snp.height)
        }
        roundImageView.layer.cornerRadius = (58 - 10) / 2
        roundImageView.clipsToBounds = true
    }
}
