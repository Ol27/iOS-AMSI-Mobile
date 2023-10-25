//
//  EventsMapViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 25.10.2023.
//

import GoogleMaps
import SnapKit
import UIKit

final class EventsMapViewController: UIViewController {
    // MARK: - UI Elements

    private let backButton = UIButton().apply {
        $0.setImage(Assets.Images.Shared.backButton.image, for: .normal)
    }

    private let searchTextField = SearchTextField(placeholderText: LocalizedStrings.searchEvents).apply {
        $0.isUserInteractionEnabled = false
    }

    private let bottomContainerView = UIView().apply {
        $0.backgroundColor = Assets.Colors.Shared.screenBackground.color
        $0.layer.cornerRadius = 40
    }

    private let hideIndicator = UIImageView().apply {
        $0.image = Assets.Images.Events.mapEventsIndicator.image
    }

    private let eventsTableView = UITableView().apply {
        $0.isScrollEnabled = false
    }

    private let mapView = GMSMapView().apply {
        $0.backgroundColor = .lightGray
    }

    // MARK: - Properties

    private let events: [Event]
    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Initialization

    init(events: [Event] = mockEvents) {
        self.events = events.filter { $0.location != nil }
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopViews()
        setupBottomContainerView()
        setupTableView()
        setupMapView()
        setupSelectors()
        configureMapView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideCustomTabBar()
        navigationController?.navigationBar.isHidden = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showCustomTabBar()
        navigationController?.navigationBar.isHidden = false
    }

    // MARK: - Setup

    private func setupTopViews() {
        view.addSubview(mapView)

        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(25)
            make.width.height.equalTo(32)
        }

        view.addSubview(searchTextField)
        searchTextField.snp.makeConstraints { make in
            make.left.equalTo(backButton.snp.right).offset(8)
            make.centerY.equalTo(backButton)
            make.height.equalTo(48)
            make.right.equalToSuperview().inset(16)
        }
    }

    private func setupBottomContainerView() {
        view.addSubview(bottomContainerView)
        bottomContainerView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(safeAreaBottomHeight + 320)
        }

        bottomContainerView.addSubview(hideIndicator)
        hideIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(12)
            make.width.equalTo(32)
            make.height.equalTo(6)
        }
    }

    private func setupTableView() {
        bottomContainerView.addSubview(eventsTableView)
        eventsTableView.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(43)
        }
        eventsTableView.register(EventCell.self, forCellReuseIdentifier: EventCell.reuseIdentifier)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
        eventsTableView.contentInset = .init(top: 0, left: 0, bottom: 80, right: 0)
    }

    private func setupMapView() {
        mapView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(bottomContainerView.snp.top).inset(40)
        }
        mapView.delegate = self
    }

    private func setupSelectors() {
        backButton.addTarget(self, action: #selector(didTapCustomBackButton), for: .touchUpInside)
    }

    // MARK: - Map configuration

    private func configureMapView() {
        if let firstEventLocation = events.first?.location {
            let camera = GMSCameraPosition.camera(withLatitude: firstEventLocation.latitude, longitude: firstEventLocation.longitude, zoom: 12)
            mapView.camera = camera
        }

        DispatchQueue.main.async { [weak self] in
            self?.addMarkersToMap()
            self?.fitAllMarkersOnMap()
        }
    }

    private func addMarkersToMap() {
        for event in events {
            guard let location = event.location else { continue }
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
            let markerView = EventMarkerView(roundImage: event.image)
            marker.iconView = markerView
            marker.userData = event
            marker.map = mapView
        }
    }

    private func fitAllMarkersOnMap() {
        let path = GMSMutablePath()
        for event in events {
            guard let location = event.location else { continue }
            path.add(CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
        }
        let bounds = GMSCoordinateBounds(path: path)
        mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 100))
    }
}

// MARK: - UITableViewDataSource

extension EventsMapViewController: UITableViewDataSource {
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

extension EventsMapViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let event = events.safeElement(at: indexPath.row) else { return }
        let viewController = EventViewController(event: event)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - GMSMapViewDelegate

extension EventsMapViewController: GMSMapViewDelegate {
    func mapView(_: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let event = marker.userData as? Event {
            let viewController = EventViewController(event: event)
            navigationController?.pushViewController(viewController, animated: true)
        }
        return true
    }
}
