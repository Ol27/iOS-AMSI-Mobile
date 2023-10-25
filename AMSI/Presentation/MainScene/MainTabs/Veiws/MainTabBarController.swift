//
//  MainTabBarController.swift
//  AMSI
//
//  Created by Anton Petrov on 10.10.2023.
//

import SnapKit
import UIKit

final class MainTabBarController: UITabBarController {
    // MARK: - UI Elements

    private let customTabBarContainer = UIView()

    private let tabBarBackgroundImageView = UIImageView(image: Assets.Images.MainTabBar.tabBarBackground.image).apply {
        $0.contentMode = .scaleToFill
        $0.isUserInteractionEnabled = true
        $0.layer.shadowColor = Assets.Colors.TabBar.tabBarShadow.color.cgColor
        $0.layer.shadowRadius = 3
        $0.layer.shadowOpacity = 1
        $0.layer.masksToBounds = false
    }

    private let searchButton = UIImageView(image: Assets.Images.MainTabBar.searchUnselected.image).apply {
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
        $0.layer.shadowColor = Assets.Colors.TabBar.searchButtonShadow.color.cgColor
        $0.layer.shadowRadius = 2
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = .init(width: 2, height: 3)
        $0.layer.masksToBounds = false
    }

    private let tabContainerStackView = UIStackView().apply {
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.isUserInteractionEnabled = true
    }

    private lazy var homeTabImageView = createTabImageView()
    private lazy var eventsTabImageView = createTabImageView()
    private lazy var jobsTabImageView = createTabImageView()
    private lazy var profileTabImageView = createTabImageView()

    private lazy var homeTabButton = createTabButton()
    private lazy var eventsTabButton = createTabButton()
    private lazy var jobsTabButton = createTabButton()
    private lazy var profileTabButton = createTabButton()

    private lazy var homeTabSelectionImageView = createSelectionImageView()
    private lazy var eventsTabSelectionImageView = createSelectionImageView()
    private lazy var jobsTabSelectionImageView = createSelectionImageView()
    private lazy var profileTabSelectionImageView = createSelectionImageView()

    // MARK: - Properties

    private var selectedTab = TabItem.home {
        didSet { switchTab() }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        setupUI()
        setupSelectors()
        switchTab()
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

    @objc private func didTapHomeTabButton() {
        selectedTab = .home
    }

    @objc private func didTapEventsTabButton() {
        selectedTab = .events
    }

    @objc private func didTapSearchTabButton() {
        selectedTab = .search
    }

    @objc private func didTapJobsTabButton() {
        selectedTab = .jobs
    }

    @objc private func didTapProfileTabButton() {
        selectedTab = .profile
    }

    // MARK: - Tab bar hide

    func hideTabBar() {
        UIView.animate(withDuration: 0.3) {
            self.customTabBarContainer.transform = CGAffineTransform(translationX: 0,
                                                                     y: self.customTabBarContainer.bounds.height)
        } completion: { _ in
            self.customTabBarContainer.isHidden = true
        }
    }

    func showTabBar() {
        customTabBarContainer.isHidden = false
        UIView.animate(withDuration: 0.3) {
            self.customTabBarContainer.transform = CGAffineTransform.identity
        }
    }

    // MARK: - Tab switches

    private func switchTab() {
        setTabsUnselected()
        selectedIndex = selectedTab.rawValue
        switch selectedTab {
        case .home:
            homeTabSelectionImageView.isHidden = false
            homeTabImageView.image = Assets.Images.MainTabBar.homeSelected.image
        case .events:
            eventsTabSelectionImageView.isHidden = false
            eventsTabImageView.image = Assets.Images.MainTabBar.eventsSelected.image
        case .search:
            searchButton.image = Assets.Images.MainTabBar.searchSelected.image
        case .jobs:
            jobsTabSelectionImageView.isHidden = false
            jobsTabImageView.image = Assets.Images.MainTabBar.jobsSelected.image
        case .profile:
            profileTabSelectionImageView.isHidden = false
            profileTabImageView.image = Assets.Images.MainTabBar.profileSelected.image
        }
    }

    private func setTabsUnselected() {
        homeTabImageView.image = Assets.Images.MainTabBar.homeUnselected.image
        eventsTabImageView.image = Assets.Images.MainTabBar.eventsUnselected.image
        searchButton.image = Assets.Images.MainTabBar.searchUnselected.image
        jobsTabImageView.image = Assets.Images.MainTabBar.jobsUnselected.image
        profileTabImageView.image = Assets.Images.MainTabBar.profileUnselected.image
        homeTabSelectionImageView.isHidden = true
        eventsTabSelectionImageView.isHidden = true
        jobsTabSelectionImageView.isHidden = true
        profileTabSelectionImageView.isHidden = true
    }

    // MARK: - Setup

    private func setupUI() {
        tabBar.isHidden = true

        view.addSubview(customTabBarContainer)
        customTabBarContainer.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(99)
        }

        customTabBarContainer.addSubview(tabBarBackgroundImageView)
        tabBarBackgroundImageView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(81)
        }

        customTabBarContainer.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(tabBarBackgroundImageView.snp.top).offset(-18)
            make.width.height.equalTo(60)
        }

        setupTabBarContainerStackView()
    }

    private func setupTabBarContainerStackView() {
        tabBarBackgroundImageView.addSubview(tabContainerStackView)
        tabContainerStackView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-4)
            make.left.right.equalToSuperview().inset(28)
        }

        tabContainerStackView.addArrangedSubview(homeTabImageView)
        tabContainerStackView.addArrangedSubview(eventsTabImageView)

        let centerButtonMirrorView = UIView()
        tabContainerStackView.addArrangedSubview(centerButtonMirrorView)
        centerButtonMirrorView.snp.makeConstraints { make in
            make.width.equalTo(searchButton)
        }

        tabContainerStackView.addArrangedSubview(jobsTabImageView)
        tabContainerStackView.addArrangedSubview(profileTabImageView)
        setupCustomTabBarContainer()
    }

    private func setupCustomTabBarContainer() {
        customTabBarContainer.addSubview(homeTabButton)
        homeTabButton.snp.makeConstraints { make in
            make.center.equalTo(homeTabImageView)
        }

        customTabBarContainer.addSubview(eventsTabButton)
        eventsTabButton.snp.makeConstraints { make in
            make.center.equalTo(eventsTabImageView)
        }

        customTabBarContainer.addSubview(jobsTabButton)
        jobsTabButton.snp.makeConstraints { make in
            make.center.equalTo(jobsTabImageView)
        }

        customTabBarContainer.addSubview(profileTabButton)
        profileTabButton.snp.makeConstraints { make in
            make.center.equalTo(profileTabImageView)
        }

        customTabBarContainer.addSubview(homeTabSelectionImageView)
        homeTabSelectionImageView.snp.makeConstraints { make in
            make.centerX.equalTo(homeTabImageView)
            make.top.equalTo(homeTabImageView.snp.bottom).offset(4)
        }

        customTabBarContainer.addSubview(eventsTabSelectionImageView)
        eventsTabSelectionImageView.snp.makeConstraints { make in
            make.centerX.equalTo(eventsTabImageView)
            make.top.equalTo(eventsTabImageView.snp.bottom).offset(4)
        }

        customTabBarContainer.addSubview(jobsTabSelectionImageView)
        jobsTabSelectionImageView.snp.makeConstraints { make in
            make.centerX.equalTo(jobsTabImageView)
            make.top.equalTo(jobsTabImageView.snp.bottom).offset(4)
        }

        customTabBarContainer.addSubview(profileTabSelectionImageView)
        profileTabSelectionImageView.snp.makeConstraints { make in
            make.centerX.equalTo(profileTabImageView)
            make.top.equalTo(profileTabImageView.snp.bottom).offset(4)
        }
    }

    private func setupSelectors() {
        homeTabButton.addTarget(self, action: #selector(didTapHomeTabButton), for: .touchUpInside)
        eventsTabButton.addTarget(self, action: #selector(didTapEventsTabButton), for: .touchUpInside)
        let searchTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapSearchTabButton))
        searchButton.addGestureRecognizer(searchTapGesture)
        jobsTabButton.addTarget(self, action: #selector(didTapJobsTabButton), for: .touchUpInside)
        profileTabButton.addTarget(self, action: #selector(didTapProfileTabButton), for: .touchUpInside)
    }

    // MARK: - Helpers

    private func createTabImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(24)
        }
        return imageView
    }

    private func createSelectionImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.image = Assets.Images.MainTabBar.selectionDot.image
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(4)
        }
        return imageView
    }

    private func createTabButton() -> UIButton {
        let button = UIButton()
        button.tintColor = .clear
        button.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
        return button
    }
}
