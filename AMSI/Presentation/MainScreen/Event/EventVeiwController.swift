//
//  EventVeiwController.swift
//  AMSI
//
//  Created by Anton Petrov on 24.10.2023.
//

import EventKit
import EventKitUI
import SnapKit
import UIKit

final class EventViewController: UIViewController {
    // MARK: - UI Elements

    private let topStackView = UIStackView().apply {
        $0.spacing = 8
    }
    private let backButton = UIButton().apply {
        $0.setImage(Assets.Images.Shared.backButton.image, for: .normal)
    }

    private let unknownButtonImageView = UIImageView().apply {
        $0.image = Assets.Images.EventDetails.unknownButton.image
    }

    private let heartButtonImageView = UIImageView().apply {
        $0.isUserInteractionEnabled = true
        $0.image = Assets.Images.EventDetails.heartButton.image
    }

    private let eventInfoScrollView = UIScrollView().apply {
        $0.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
    }

    private let eventInfoStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 20
    }

    private let eventImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    private let eventTitleLabel = CustomStyleLabel(fontSize: 20, isBold: true, numberOfLines: 0)

    private let dateHorizontalStackView = UIStackView().apply {
        $0.alignment = .center
        $0.spacing = 16
    }

    private let dateContainerView = UIView().apply {
        $0.backgroundColor = Assets.Colors.Shared.actionButtonBackground.color
        $0.layer.cornerRadius = 8
    }

    private let dateStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.distribution = .fillEqually
    }

    private let dateDayLabel = CustomStyleLabel(fontSize: 14, isBold: true, alignment: .center)
    private let dateMonthLabel = CustomStyleLabel(fontSize: 10,
                                                  fontColor: Assets.Colors.Shared.lightGrayText.color,
                                                  alignment: .center)

    private let weekDateTimeVerticalStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = -3
    }

    private let weekDateLabel = CustomStyleLabel(fontSize: 14, isBold: true)
    private let timeLabel = CustomStyleLabel(fontSize: 12,
                                             fontColor: Assets.Colors.Shared.lightGrayText.color)

    private let calendarButtonImageView = UIImageView().apply {
        $0.isUserInteractionEnabled = true
        $0.image = Assets.Images.EventDetails.calendarButton.image
    }

    private let addressContainerView = UIView()
    private let addressIconImageView = UIImageView().apply {
        $0.image = Assets.Images.EventDetails.addressIcon.image
    }
    private let addressTitleLabel = CustomStyleLabel(text: LocalizedStrings.eventAddressTitle,
                                                     fontSize: 16,
                                                     isBold: true)
    private let copyAddressButtonImageView = UIImageView().apply {
        $0.isUserInteractionEnabled = true
        $0.image = Assets.Images.EventDetails.copyButton.image
    }
    private let addressLabel = CustomStyleLabel(fontSize: 14,
                                                fontColor: Assets.Colors.Shared.lightGrayText.color)

    private let contactInformationContainerView = UIView()
    private let contactInformationIconImageView = UIImageView().apply {
        $0.image = Assets.Images.EventDetails.contactInfoIcon.image
    }
    private let contactInformationTitleLabel = CustomStyleLabel(text: LocalizedStrings.eventContactInfoTitle,
                                                                fontSize: 16,
                                                                isBold: true)
    private let contactInformationLabel = CustomStyleLabel(fontSize: 14,
                                                           fontColor: Assets.Colors.Shared.lightGrayText.color)

    private let aboutInfoVerticalStackView = UIStackView().apply {
        $0.axis = .vertical
        $0.spacing = 8
    }

    private let aboutTitleLabel = CustomStyleLabel(text: LocalizedStrings.eventAboutTitle,
                                                   fontSize: 16,
                                                   isBold: true)
    private let aboutLabel = CustomStyleLabel(fontSize: 14,
                                              fontColor: Assets.Colors.Shared.lightGrayText.color,
                                              numberOfLines: 0)

    // MARK: - Properties

    private let eventStore = EKEventStore()
    private let event: Event
    private var isFavorite = false

    // MARK: - Initialization

    init(event: Event) {
        self.event = event
        super.init(nibName: nil, bundle: nil)
        eventImageView.image = event.image
        eventTitleLabel.text = event.name
        dateDayLabel.text = event.dayDate
        dateMonthLabel.text = event.monthDate
        weekDateLabel.text = event.weekDay
        timeLabel.text = event.time + " - " + event.endTime
        contactInformationLabel.text = event.phone
        addressLabel.text = event.address
        contactInformationLabel.text = event.phone
        aboutLabel.text = event.aboutInfo
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        setupTopStackView()
        setupScrollView()
        setupStackView()
        setupStackViewElements()
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

    @objc private func didTapHeartButton() {
        isFavorite.toggle()
        heartButtonImageView.fadeInWithFeedback()
        heartButtonImageView.image = isFavorite
        ? Assets.Images.EventDetails.heartFilledButton.image
        : Assets.Images.EventDetails.heartButton.image
    }

    @objc private func didTapCopyButton() {
        UIPasteboard.general.string = event.address
        copyAddressButtonImageView.fadeInWithFeedback()
    }

    @objc private func didTapCalendarButton() {
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            presentEventEditController()
        case .denied:
            showAlertToOpenCalendarPermissionsSettings()
        case .notDetermined:
            eventStore.requestAccess(to: .event) { [weak self] (granted, _) -> Void in
                DispatchQueue.main.async {
                    if granted {
                        self?.presentEventEditController()
                    } else {
                        self?.showAlertToOpenCalendarPermissionsSettings()
                    }
                }
            }
        default:
            break
        }
    }

    // MARK: - Helpers

    private func presentEventEditController() {
        copyAddressButtonImageView.fadeInWithFeedback()
        let createdEvent = EKEvent(eventStore: eventStore)
        createdEvent.title = event.name
        createdEvent.startDate = Date()
        createdEvent.endDate = Date().addingTimeInterval(60*60)
        createdEvent.notes = event.aboutInfo
        createdEvent.location = event.address
        let editViewController = EKEventEditViewController()
        editViewController.view.backgroundColor = .systemGray6
        editViewController.event = createdEvent
        editViewController.eventStore = eventStore
        editViewController.editViewDelegate = self
        self.present(editViewController, animated: true, completion: nil)
    }

    private func showAlertToOpenCalendarPermissionsSettings() {
        let alertController = UIAlertController(title: LocalizedStrings.calendarPermissionsAlertTitle,
                                                message: LocalizedStrings.calendarPermissionsAlertText,
                                                preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: LocalizedStrings.calendarPermissionAlertSettingsButton,
                                           style: .default) { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsUrl)
            else { return }
            UIApplication.shared.open(settingsUrl)
        }
        let cancelAction = UIAlertAction(title: LocalizedStrings.calendarPermissionsAlertCancelButton,
                                         style: .default,
                                         handler: nil)
        alertController.addAction(settingsAction)
        alertController.addAction(cancelAction)
        hideActivityIndicator()
        present(alertController, animated: true)
    }

}

extension EventViewController: EKEventEditViewDelegate {
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}

    // MARK: - Setup

extension EventViewController {
    private func setupTopStackView() {
        view.addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(16)
            make.height.equalTo(40)
        }
        topStackView.addArrangedSubview(backButton)
        topStackView.addArrangedSubview(UIView())
        topStackView.addArrangedSubview(unknownButtonImageView)
        topStackView.addArrangedSubview(heartButtonImageView)
    }

    private func setupScrollView() {
        view.addSubview(eventInfoScrollView)
        eventInfoScrollView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(topStackView.snp.bottom).offset(8)
        }
    }

    private func setupStackView() {
        eventInfoScrollView.addSubview(eventInfoStackView)
        eventInfoStackView.snp.makeConstraints { make in
            make.top.bottom.equalTo(eventInfoScrollView)
            make.left.right.equalTo(view).inset(24)
            make.width.equalTo(view).inset(24)
        }
    }

    private func setupStackViewElements() {
        eventInfoStackView.addArrangedSubview(eventImageView)
        eventImageView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(eventImageView.snp.width).multipliedBy(240.0/327.0)
        }

        eventInfoStackView.addArrangedSubview(eventTitleLabel)
        setupDateHorizontalStack()
        setupAddressView()
        setupContactInformationView()
        setupAboutInfoView()
    }

    private func setupDateHorizontalStack() {
        eventInfoStackView.addArrangedSubview(dateHorizontalStackView)
        dateHorizontalStackView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        dateHorizontalStackView.addArrangedSubview(dateContainerView)
        dateContainerView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }

        dateContainerView.addSubview(dateStackView)
        dateStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(2)
        }

        dateStackView.addArrangedSubview(dateDayLabel)
        dateStackView.addArrangedSubview(dateMonthLabel)

        dateHorizontalStackView.addArrangedSubview(weekDateTimeVerticalStackView)
        weekDateTimeVerticalStackView.addArrangedSubview(weekDateLabel)
        weekDateTimeVerticalStackView.addArrangedSubview(timeLabel)
        dateHorizontalStackView.addArrangedSubview(calendarButtonImageView)
        calendarButtonImageView.snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
    }

    private func setupAddressView() {
        eventInfoStackView.addArrangedSubview(addressContainerView)
        addressContainerView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        addressContainerView.addSubview(addressIconImageView)
        addressIconImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.width.equalTo(24)
        }
        addressContainerView.addSubview(addressTitleLabel)
        addressTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(addressIconImageView.snp.right).offset(8)
            make.centerY.equalTo(addressIconImageView.snp.centerY)
            make.right.equalToSuperview()
        }

        addressContainerView.addSubview(copyAddressButtonImageView)
        copyAddressButtonImageView.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview()
            make.width.height.equalTo(24)
        }

        addressContainerView.addSubview(addressLabel)
        addressLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalTo(copyAddressButtonImageView)
            make.right.equalTo(copyAddressButtonImageView.snp.left).offset(8)
        }
    }

    private func setupContactInformationView() {
        eventInfoStackView.addArrangedSubview(contactInformationContainerView)
        contactInformationContainerView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        contactInformationContainerView.addSubview(contactInformationIconImageView)
        contactInformationIconImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.height.width.equalTo(24)
        }
        contactInformationContainerView.addSubview(contactInformationTitleLabel)
        contactInformationTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(contactInformationIconImageView.snp.right).offset(8)
            make.centerY.equalTo(contactInformationIconImageView.snp.centerY)
            make.right.equalToSuperview()
        }
        contactInformationContainerView.addSubview(contactInformationLabel)
        contactInformationLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(contactInformationTitleLabel.snp.bottom)
        }
    }

    private func setupAboutInfoView() {
        eventInfoStackView.addArrangedSubview(aboutInfoVerticalStackView)
        aboutInfoVerticalStackView.addArrangedSubview(aboutTitleLabel)
        aboutInfoVerticalStackView.addArrangedSubview(aboutLabel)
    }

    private func setupSelectors() {
        backButton.addTarget(self, action: #selector(didTapCustomBackButton), for: .touchUpInside)

        let copyTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCopyButton))
        copyAddressButtonImageView.addGestureRecognizer(copyTapGesture)

        let favoriteTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapHeartButton))
        heartButtonImageView.addGestureRecognizer(favoriteTapGesture)

        let calendarTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCalendarButton))
        calendarButtonImageView.addGestureRecognizer(calendarTapGesture)
    }
}
