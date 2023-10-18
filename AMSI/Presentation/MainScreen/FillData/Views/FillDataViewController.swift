//
//  FillDataViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 12.10.2023.
//

import Photos
import SnapKit
import UIKit

protocol FillDataDelegate: AnyObject {
    func didFillDataFor(user: UserData)
}

final class FillDataViewController: UIViewController {
    // MARK: - UI Elements

    private let topStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
        $0.alignment = .center
    }

    private let bottomStackView = UIStackView().apply {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fill
        $0.alignment = .center
    }

    private let iconImageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = CustomStyleLabel(fontSize: 24,
                                              isBold: true,
                                              alignment: .left)

    private let skipButton = UIButton().apply {
        $0.setTitle(LocalizedStrings.skipButton, for: .normal)
        $0.setTitleColor(Assets.Colors.Shared.mainAccent.color, for: .normal)
        $0.titleLabel?.font = Fonts.NotoSansJP.bold.font(size: 14)
    }

    private let containerStackView = UIStackView().apply {
        $0.axis = .vertical
    }

    private let uploadPhotoView = UIView()

    private let photoImageView = RoundImageView().apply {
        $0.image = Assets.Images.FillData.addPhotoPlaceholder.image
        $0.contentMode = .scaleToFill
    }

    private let uploadPhotoButton = FilledButton(text: LocalizedStrings.uploadPhotoButton)

    private let contactInfoView = UIView()

    private let phoneTextfield = AuthorizationTextField(placeholderText: "+ 1",
                                                        icon: Assets.Images.FillData.usaFlag.image)

    private let emailTextField = AuthorizationTextField(placeholderText: LocalizedStrings.email, icon: Assets.Images.SignUp.emailIcon.image)

    private let addressTableView = UITableView().apply {
        $0.backgroundColor = .clear
        $0.isScrollEnabled = false
        $0.isHidden = true
    }

    private let pageView = UIImageView()

    private let nextPageButton = UIButton().apply {
        $0.setImage(Assets.Images.FillData.nextButton.image, for: .normal)
    }

    // MARK: - Properties

    private var userData = UserData()
    private var step = FillDataStep.addPhoto
    weak var coordinator: TabCoordinatorProtocol?
    weak var delegate: FillDataDelegate?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        animateToStep(step)
        configureTableView()
        setupSelectors()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }

    // MARK: - Actions

    @objc private func didTapSkipButton() {
        animateToStep(.contactInfo)
    }

    @objc private func handleNextPageButtonTap() {
        switch step {
        case .addPhoto:
            animateToStep(.contactInfo)
        case .contactInfo:
            animateToStep(.address)
        case .address:
            delegate?.didFillDataFor(user: userData)
            dismiss(animated: true) { [weak self] in
                guard let self, let city = self.userData.city, let country = self.userData.country else { return }
                SettingsManager.shared.didFilledData = true
            }
        }
    }

    @objc private func didTapUploadPhotoButton() {
        requestPhotoLibraryAuthorization()
    }

    // MARK: - Helpers

    private func animateToStep(_ newStep: FillDataStep) {
        UIView.transition(with: view, duration: 0.3, options: .curveEaseInOut) {
            switch newStep {
            case .addPhoto:
                break
            case .contactInfo:
                self.skipButton.alpha = 0
                self.uploadPhotoView.alpha = 0
                self.contactInfoView.alpha = 1
            case .address:
                self.skipButton.alpha = 0
                self.contactInfoView.alpha = 0
                self.addressTableView.alpha = 1
            }
            self.iconImageView.image = newStep.iconImage
            self.titleLabel.text = newStep.titleText
            self.pageView.image = newStep.pageControlImage
        } completion: { _ in
            switch newStep {
            case .addPhoto:
                self.uploadPhotoView.isHidden = false
                self.contactInfoView.isHidden = true
                self.addressTableView.isHidden = true
            case .contactInfo:
                self.skipButton.isHidden = true
                self.uploadPhotoView.isHidden = true
                self.contactInfoView.isHidden = false
            case .address:
                self.skipButton.isHidden = true
                self.contactInfoView.isHidden = true
                self.addressTableView.isHidden = false
            }
            self.step = newStep
        }
    }

    // MARK: - Setup

    private func configureTableView() {
        addressTableView.register(AddressDataCell.self,
                                  forCellReuseIdentifier: AddressDataCell.reuseIdentifier)
        addressTableView.dataSource = self
        addressTableView.delegate = self
    }

    private func setupUI() {
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        view.addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.left.right.equalToSuperview().inset(24)
        }

        topStackView.addArrangedSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }

        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(skipButton)

        view.addSubview(bottomStackView)
        bottomStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(24)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        bottomStackView.addArrangedSubview(pageView)
        pageView.snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(8)
        }
        bottomStackView.addArrangedSubview(UIView())

        bottomStackView.addArrangedSubview(nextPageButton)
        nextPageButton.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }

        view.addSubview(containerStackView)
        containerStackView.snp.makeConstraints { make in
            make.top.equalTo(topStackView.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalTo(bottomStackView.snp.top).offset(-24)
        }

        containerStackView.addArrangedSubview(uploadPhotoView)
        uploadPhotoView.snp.makeConstraints { make in
            make.height.equalTo(192)
        }
        uploadPhotoView.addSubview(photoImageView)
        photoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(120)
        }

        uploadPhotoView.addSubview(uploadPhotoButton)
        uploadPhotoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(154)
            make.height.equalTo(48)
        }

        containerStackView.addArrangedSubview(contactInfoView)
        contactInfoView.snp.makeConstraints { make in
            make.height.equalTo(128)
        }

        contactInfoView.addSubview(phoneTextfield)
        phoneTextfield.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }

        contactInfoView.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.bottom.left.right.equalToSuperview()
        }

        containerStackView.addArrangedSubview(addressTableView)
        containerStackView.addArrangedSubview(UIView())
    }

    private func setupSelectors() {
        nextPageButton.addTarget(self, action: #selector(handleNextPageButtonTap), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        uploadPhotoButton.addTarget(self, action: #selector(didTapUploadPhotoButton), for: .touchUpInside)
    }
}

// MARK: - UITableViewDataSource

extension FillDataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AddressData.allCases.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressDataCell.reuseIdentifier,
                                                       for: indexPath) as? AddressDataCell,
            let data = AddressData(rawValue: indexPath.row)
        else { return UITableViewCell() }
        let text: String?
        switch data {
        case .addressLineOne:
            text = userData.addressLineOne
        case .addressLineTwo:
            text = userData.addressLineTwo
        case .country:
            text = userData.country
        case .city:
            text = userData.city
        case .zipCode:
            text = userData.zipCode
        }
        cell.configure(withData: data, text: text)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FillDataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let addressData = AddressData(rawValue: indexPath.row) else { return }
        let selectionController: SelectionViewController
        switch addressData {
        case .country:
            let country = userData.countryId
            selectionController = SelectionViewController(selectionType: .country(country))
        case .city:
            let city = userData.cityId
            selectionController = SelectionViewController(selectionType: .city(city))
        default:
            return
        }
        selectionController.delegate = self
        navigationController?.pushViewController(selectionController, animated: true)
    }
}

// MARK: - ImagePickerDelegate

extension FillDataViewController: ImagePickerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let pickedImage = info[.editedImage] as? UIImage else { return }
        photoImageView.image = pickedImage
        userData.image = pickedImage
        picker.dismiss(animated: true) {
            self.hideActivityIndicator()
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {
            self.hideActivityIndicator()
        }
    }
}

// MARK: - SelectionViewControllerDelegate

extension FillDataViewController: SelectionViewControllerDelegate {
    func didSelect(item: SelectionType, atIndex: Int) {
        switch item {
        case let .city(int):
            userData.cityId = int
        case let .country(int):
            userData.countryId = int
        }
        addressTableView.reloadData()
    }
}
