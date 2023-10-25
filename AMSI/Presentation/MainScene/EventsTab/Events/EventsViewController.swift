//
//  EventsViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 16.10.2023.
//

import SnapKit
import UIKit

final class EventsViewController: UIViewController {
    // MARK: - UI Elements

    private let topStackView = UIStackView().apply {
        $0.spacing = 8
    }

    private let titleLabel = CustomStyleLabel(text: LocalizedStrings.eventsScreenTitle,
                                              fontSize: 20,
                                              isBold: true)

    private let searchButtonImageView = UIImageView().apply {
        $0.image = Assets.Images.Events.searchButton.image
    }

    private let mapButtonImageView = UIImageView().apply {
        $0.image = Assets.Images.Events.mapButton.image
        $0.isUserInteractionEnabled = true
    }

    private let eventsTableView = UITableView()

    // MARK: - Properties

    private let events: [Event]
    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Initialization

    init(events: [Event] = mockEvents) {
        self.events = events
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopStackView()
        setupTableView()
        setupSelectors()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Actions

    @objc private func didTapMapButton() {
        mapButtonImageView.fadeInWithFeedback()
        let viewController = EventsMapViewController(events: events)
        navigationController?.pushViewController(viewController, animated: true)
    }

    // MARK: - Setup

    private func setupTopStackView() {
        view.addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(32)
            make.height.equalTo(40)
        }
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(searchButtonImageView)
        topStackView.addArrangedSubview(mapButtonImageView)
    }

    private func setupTableView() {
        view.addSubview(eventsTableView)
        eventsTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topStackView.snp.bottom).offset(8)
        }
        eventsTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.contentInset = .init(top: 0, left: 0, bottom: 80, right: 0)
    }

    private func setupSelectors() {
        let mapTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMapButton))
        mapButtonImageView.addGestureRecognizer(mapTapGesture)
    }
}

// MARK: - UITableViewDataSource

extension EventsViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        events.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.reuseIdentifier,
                                                       for: indexPath) as? EventCell,
            let event = events.safeElement(at: indexPath.row)
        else { return UITableViewCell() }
        cell.configure(withEvent: event)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EventsViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = events.safeElement(at: indexPath.row) else { return }
        let viewController = EventViewController(event: event)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
