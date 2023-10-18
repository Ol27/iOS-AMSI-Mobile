//
//  HomeEventCell.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import SnapKit
import UIKit

final class HomeEventCell: UICollectionViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
    }

    private let dateContainerView = UIView().apply {
        $0.backgroundColor = Assets.Colors.Shared.screenBackground.color
        $0.layer.cornerRadius = 8
    }

    private let dateStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }

    private let dateDayLabel = CustomStyleLabel(fontSize: 14, isBold: true, alignment: .center)
    private let dateMonthLabel = CustomStyleLabel(fontSize: 10,
                                                  fontColor: Assets.Colors.Shared.secondaryText.color,
                                                  alignment: .center)

    private let bottomInfoContainerView = UIView().apply {
        $0.backgroundColor = Assets.Colors.Shared.screenBackground.color
        $0.layer.cornerRadius = 10
    }

    private let infoContainerVerticalStackView = UIStackView().apply {
        $0.axis = .vertical
    }

    private let eventNameLabel = CustomStyleLabel(fontSize: 14, isBold: true, numberOfLines: 2)

    private let bottomInfoContainerStackView = UIStackView().apply {
        $0.spacing = 4
    }

    private let eventLocationLabel = CustomStyleLabel(fontSize: 12,
                                                      fontColor: Assets.Colors.Shared.secondaryText.color)

    private let dotSeparatorImageView = UIImageView().apply {
        $0.image = Assets.Images.Shared.separatorDot.image
        $0.contentMode = .scaleAspectFit
    }

    private let eventTimeLabel = CustomStyleLabel(fontSize: 12,
                                                  fontColor: Assets.Colors.Shared.secondaryText.color)

    private let openButton = SmallActionButton(text: LocalizedStrings.openButton)

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
    }

    // MARK: - Configuration

    func configure(withEvent event: Event) {
        imageView.image = event.image
        eventNameLabel.text = event.name
        dateDayLabel.text = event.dayDate
        dateMonthLabel.text = event.monthDate
        eventLocationLabel.text = event.city
        eventTimeLabel.text = event.time
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(250)
            make.height.equalTo(290)
            make.edges.equalToSuperview()
        }

        contentView.addSubview(dateContainerView)
        dateContainerView.snp.makeConstraints { make in
            make.right.top.equalToSuperview().inset(12)
            make.width.height.equalTo(48)
        }

        dateContainerView.addSubview(dateStackView)
        dateStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        dateStackView.addArrangedSubview(dateDayLabel)
        dateStackView.addArrangedSubview(dateMonthLabel)

        contentView.addSubview(bottomInfoContainerView)
        bottomInfoContainerView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview().inset(12)
            make.height.equalTo(106)
        }

        bottomInfoContainerView.addSubview(infoContainerVerticalStackView)
        infoContainerVerticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }

        infoContainerVerticalStackView.addArrangedSubview(eventNameLabel)
        infoContainerVerticalStackView.addArrangedSubview(UIView())

        infoContainerVerticalStackView.addArrangedSubview(bottomInfoContainerStackView)
        bottomInfoContainerStackView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }

        bottomInfoContainerStackView.addArrangedSubview(eventLocationLabel)
        bottomInfoContainerStackView.addArrangedSubview(dotSeparatorImageView)
        dotSeparatorImageView.snp.makeConstraints { make in
            make.width.height.equalTo(4)
        }

        bottomInfoContainerStackView.addArrangedSubview(eventTimeLabel)
        bottomInfoContainerStackView.addArrangedSubview(UIView())
        bottomInfoContainerStackView.addArrangedSubview(openButton)
    }
}
