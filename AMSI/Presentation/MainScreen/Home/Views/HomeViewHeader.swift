//
//  HomeViewHeader.swift
//  AMSI
//
//  Created by Anton Petrov on 18.10.2023.
//

import SnapKit
import UIKit

final class HomeViewHeader: UIView {
    private let infoLabel = CustomStyleLabel(text: LocalizedStrings.homeScreenInfo,
                                             fontSize: 12,
                                             fontColor: Assets.Colors.Shared.secondaryText.color)

    private let cityLabel = CustomStyleLabel(fontSize: 18,
                                             isBold: true)

    private let userImageView = RoundImageView(image: Assets.Images.FillData.addPhotoPlaceholder.image)

    private let upcomingEventsLabel = CustomStyleLabel(text: LocalizedStrings.upcomingEventsTitle,
                                                       fontSize: 16,
                                                       isBold: true)

    private let seeAllLabel = CustomStyleLabel(text: LocalizedStrings.seeAllButton,
                                               fontSize: 14,
                                               fontColor: Assets.Colors.Shared.secondaryText.color,
                                               alignment: .right)

    private lazy var eventsCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HomeEventCell.self,
                                forCellWithReuseIdentifier: HomeEventCell.reuseIdentifier)
        return collectionView
    }()

    private let jobsTitleLabel = CustomStyleLabel(text: LocalizedStrings.jobsForYouTitle,
                                                  fontSize: 16,
                                                  isBold: true)

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.width.height.equalTo(42)
            make.top.equalToSuperview().inset(5)
            make.right.equalToSuperview().inset(24)
        }

        addSubview(infoLabel)
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalToSuperview().inset(24)
            make.right.equalTo(userImageView.snp.left).offset(8)
        }

        addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userImageView)
            make.left.equalToSuperview().inset(24)
            make.right.equalTo(userImageView.snp.left).inset(8)
        }

        let topStackView = UIStackView()
        addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(userImageView.snp.bottom).offset(15)
        }
        topStackView.addArrangedSubview(upcomingEventsLabel)
        topStackView.addArrangedSubview(UIView())
        topStackView.addArrangedSubview(seeAllLabel)

        addSubview(jobsTitleLabel)
        jobsTitleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
        }

        addSubview(eventsCollectionView)
        eventsCollectionView.snp.makeConstraints { make in
            make.bottom.equalTo(jobsTitleLabel.snp.top)
            make.top.equalTo(topStackView.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewHeader: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        mockEvents.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeEventCell.reuseIdentifier,
                                                            for: indexPath) as? HomeEventCell else { return UICollectionViewCell() }
        cell.configure(withEvent: mockEvents[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout

extension HomeViewHeader: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 250, height: 290)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}
