//
//  OnboardingViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

final class OnboardingViewController: UIViewController {
    // MARK: - UI elements

    private let backgroundImageView = UIImageView().apply {
        $0.contentMode = .scaleToFill
        $0.image = Assets.Images.Onboarding.onboardingBackground.image
    }

    private let skipButton = UIButton().apply {
        $0.setTitle(LocalizedStrings.skipButton, for: .normal)
        $0.setTitleColor(Assets.Colors.Shared.mainAccent.color, for: .normal)
        $0.titleLabel?.font = Fonts.NotoSansJP.bold.font(size: 16)
    }

    private let imageView = UIImageView().apply {
        $0.contentMode = .scaleAspectFit
    }

    private let titleLabel = CustomStyleLabel(fontSize: 23, isBold: true, alignment: .center)
    private let textLabel = CustomStyleLabel(fontSize: 14,
                                             fontColor: Assets.Colors.Shared.secondaryText.color,
                                             alignment: .center,
                                             numberOfLines: 0)
    private let nextButton = UIButton()

    // MARK: - Properties

    private var currentElement: OnboardingElement = .first {
        didSet {
            updateUI(for: currentElement)
        }
    }

    weak var coordinator: AuthCoordinatorProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateUI(for: currentElement)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    // MARK: - Actions

    @objc private func nextButtonTapped() {
        switch currentElement {
        case .first:
            currentElement = .second
        case .second:
            currentElement = .third
        case .third:
            coordinator?.dismissOnboarding()
        }
    }

    @objc private func skipButtonPressed() {
        coordinator?.dismissOnboarding()
    }

    // MARK: - Setup

    private func setupUI() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        view.addSubview(skipButton)
        skipButton.addTarget(self, action: #selector(skipButtonPressed), for: .touchUpInside)
        skipButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(6)
            make.width.height.equalTo(44)
        }

        view.addSubview(nextButton)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(27)
            make.width.height.equalTo(88)
        }

        view.addSubview(textLabel)
        textLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(nextButton.snp.top).offset(-54)
            make.height.equalTo(44)
            make.left.right.equalToSuperview().inset(20)
        }

        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textLabel.snp.top).offset(-12)
            make.height.equalTo(36)
            make.left.right.equalToSuperview().inset(20)
        }

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(66)
            make.bottom.equalTo(titleLabel.snp.top).offset(-94)
            make.left.right.equalToSuperview().inset(38)
        }
    }

    private func updateUI(for element: OnboardingElement) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve) {
            self.imageView.image = element.image
            self.titleLabel.text = element.titleText
            self.textLabel.text = element.text
            self.nextButton.setImage(element.buttonImage, for: .normal)
        }
    }
}
