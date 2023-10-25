//
//  HomeJobCell.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import SnapKit
import UIKit

final class HomeJobCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let containerView = UIView().apply {
        $0.backgroundColor = Assets.Colors.Shared.cellBackground.color
        $0.layer.cornerRadius = 8
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = Assets.Colors.Shared.border.color.cgColor
    }

    private let containerStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 16
    }

    private let topContainerStackView = UIStackView().apply {
        $0.distribution = .fill
        $0.spacing = 16
    }

    private let jobImageView = RoundImageView().apply {
        $0.contentMode = .scaleToFill
    }

    private let titleCompanyStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 4
    }

    private let jobTitleLabel = CustomStyleLabel(fontSize: 16, isBold: true)
    private let companyNameLabel = CustomStyleLabel(fontSize: 12,
                                                    fontColor: Assets.Colors.Shared.secondaryText.color)

    private let tagsStackView = UIStackView().apply {
        $0.spacing = 8
        $0.distribution = .fill
    }

    private let hourlyRateTag = TagView(backgroundColor: Assets.Colors.Home.hourlyRateTag.color)

    private let infoTag = TagView(backgroundColor: Assets.Colors.Home.infoTag.color)

    private let typeTag = TagView(backgroundColor: Assets.Colors.Home.typeTag.color)

    private let locationDateStackView = UIStackView().apply {
        $0.spacing = 6
    }

    private let locationIconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.Images.Home.locationIcon.image
    }

    private let distanceLabel = CustomStyleLabel(fontSize: 14, isBold: true)

    private let timeIconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
        $0.image = Assets.Images.Home.timeIcon.image
    }

    private let timeLabel = CustomStyleLabel(fontSize: 14, isBold: true)

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configure

    func configure(withJob job: Job) {
        jobImageView.image = job.image
        jobTitleLabel.text = job.name
        companyNameLabel.text = job.company
        hourlyRateTag.text = job.hourlyRate
        infoTag.text = job.additionalInfo
        typeTag.text = job.type
        distanceLabel.text = job.distance
        timeLabel.text = job.datePublished
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8,
                                                             left: 16,
                                                             bottom: 8,
                                                             right: 16))
        }

        containerView.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }

        containerStackView.addArrangedSubview(topContainerStackView)

        topContainerStackView.addArrangedSubview(jobImageView)
        jobImageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }

        topContainerStackView.addArrangedSubview(titleCompanyStackView)
        titleCompanyStackView.snp.makeConstraints { make in
            make.height.equalTo(44)
        }
        titleCompanyStackView.addArrangedSubview(jobTitleLabel)
        titleCompanyStackView.addArrangedSubview(companyNameLabel)

        containerStackView.addArrangedSubview(tagsStackView)
        tagsStackView.addArrangedSubview(hourlyRateTag)
        tagsStackView.addArrangedSubview(typeTag)
        tagsStackView.addArrangedSubview(infoTag)
        tagsStackView.addArrangedSubview(UIView())

        containerStackView.addArrangedSubview(locationDateStackView)
        locationDateStackView.addArrangedSubview(locationIconImageView)
        locationDateStackView.addArrangedSubview(distanceLabel)
        locationDateStackView.addArrangedSubview(UIView())
        locationDateStackView.addArrangedSubview(timeIconImageView)
        locationDateStackView.addArrangedSubview(timeLabel)
    }
}
