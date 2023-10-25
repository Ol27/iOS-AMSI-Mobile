//
//  SelectionViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import SnapKit
import UIKit

protocol SelectionViewControllerDelegate: AnyObject {
    func didSelect(item: SelectionType, atIndex: Int)
}

final class SelectionViewController: UIViewController {
    // MARK: - UI Elements

    private let titleLabel = CustomStyleLabel(fontSize: 24,
                                              isBold: true,
                                              alignment: .left)

    private let selectionTableView = UITableView()
    private let createNewPasswordButton = FilledButton(text: LocalizedStrings.saveButton)

    // MARK: - Properties

    weak var delegate: SelectionViewControllerDelegate?
    private var selectionType: SelectionType
    private let items: [String]
    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Initialization

    init(selectionType: SelectionType) {
        self.selectionType = selectionType
        items = selectionType.items
        print("DEBUG! items: \(items.count)")
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = selectionType.title
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupCustomBackButton()
        setupSelectors()
        setupNavigationBar()
        setupCustomBackButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }

    // MARK: - Actions

    @objc private func didTapSaveButton() {
        guard let selectedIndex = selectionType.associatedValue else { return }
        delegate?.didSelect(item: selectionType, atIndex: selectedIndex)
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Setup

    private func setup() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(30)
        }

        view.addSubview(createNewPasswordButton)
        createNewPasswordButton.snp.remakeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(12)
            make.height.equalTo(56)
        }

        view.addSubview(selectionTableView)
        selectionTableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(createNewPasswordButton.snp.top).offset(-16)
        }

        selectionTableView.register(SelectionCell.self,
                                    forCellReuseIdentifier: SelectionCell.reuseIdentifier)
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
    }

    private func setupSelectors() {
        createNewPasswordButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

// MARK: - UITableViewDataSource

extension SelectionViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.reuseIdentifier,
                                                       for: indexPath) as? SelectionCell
        else { return UITableViewCell() }
        let item = items[indexPath.row]
        let isSelected = selectionType.associatedValue == indexPath.row
        cell.configure(withItem: item, isSelected: isSelected)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectionType {
        case .city:
            selectionType = .city(indexPath.row)
        case .country:
            selectionType = .country(indexPath.row)
        }
        tableView.reloadData()
    }
}
