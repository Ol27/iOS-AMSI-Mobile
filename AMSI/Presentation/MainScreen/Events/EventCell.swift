//
//  EventCell.swift
//  AMSI
//
//  Created by Anton Petrov on 24.10.2023.
//

import SnapKit
import UIKit


final class EventCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let containerView = UIView().apply {
        $0.backgroundColor = Assets.Colors.Shared.screenBackground.color
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.darkGray.cgColor
        $0.layer.shadowOffset = CGSize(width: 3, height: 3)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.1
    }

    private let previewImageView = UIImageView().apply {
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

    private let infoContainerView = UIView()

    private let infoContainerVerticalStackView = UIStackView().apply {
        $0.axis = .vertical
    }

    private let eventNameLabel = CustomStyleLabel(fontSize: 14, isBold: true, numberOfLines: 2)

    private let infoContainerStackView = UIStackView().apply {
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

    private let openButton = SmallActionButton(text: LocalizedStrings.eventsFreeButton)

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(withEvent event: Event) {
        previewImageView.image = event.image
        eventNameLabel.text = event.name
        dateDayLabel.text = event.dayDate
        dateMonthLabel.text = event.monthDate
        eventLocationLabel.text = event.city
        eventTimeLabel.text = event.time
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8,
                                                             left: 24,
                                                             bottom: 8,
                                                             right: 24))
        }
        containerView.addSubview(previewImageView)
        previewImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview().inset(12)
            make.height.equalTo(96)
            make.width.equalTo(88)
        }

        previewImageView.addSubview(dateContainerView)
        dateContainerView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().inset(8)
            make.width.height.equalTo(32)
        }

        dateContainerView.addSubview(dateStackView)
        dateStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }

        dateStackView.addArrangedSubview(dateDayLabel)
        dateStackView.addArrangedSubview(dateMonthLabel)

        containerView.addSubview(infoContainerView)
        infoContainerView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview().inset(15)
            make.left.equalTo(previewImageView.snp.right).offset(12)
        }

        infoContainerView.addSubview(infoContainerVerticalStackView)
        infoContainerVerticalStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        infoContainerVerticalStackView.addArrangedSubview(eventNameLabel)
        infoContainerVerticalStackView.addArrangedSubview(infoContainerStackView)
        infoContainerStackView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }

        infoContainerStackView.addArrangedSubview(eventLocationLabel)
        infoContainerStackView.addArrangedSubview(dotSeparatorImageView)
        dotSeparatorImageView.snp.makeConstraints { make in
            make.width.height.equalTo(4)
        }

        infoContainerStackView.addArrangedSubview(eventTimeLabel)
        infoContainerStackView.addArrangedSubview(UIView())
        infoContainerStackView.addArrangedSubview(openButton)
    }
}
