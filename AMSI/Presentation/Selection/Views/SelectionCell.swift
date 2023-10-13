//
//  SelectionCell.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import UIKit

final class SelectionCell: UITableViewCell, ReuseIdentifier {
    // MARK: - UI Elements

    private let label = CustomStyleLabel(fontSize: 16)
    private let iconImageView = UIImageView().apply {
        $0.image = Assets.Images.Shared.pickArrow.image
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }

    private let backgroundContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = Assets.Colors.Shared.textFieldBackground.color
        view.layer.cornerRadius = 8
        return view
    }()

    // MARK: - Properties

    private let iconImageViewSideSize: CGFloat = 24
    private lazy var cellInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    private lazy var contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Configuration

    func configure(withItem item: String, isSelected: Bool) {
        label.text = item
        iconImageView.isHidden = !isSelected
    }

    // MARK: - Setup

    private func setup() {
        contentView.addSubview(backgroundContainerView)
        backgroundContainerView.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.bottom.equalToSuperview().inset(8)
            make.left.right.equalToSuperview().inset(24)
        }

        backgroundContainerView.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.left.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
        }

        backgroundContainerView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(20)
            make.width.height.equalTo(20)
        }
    }
}
