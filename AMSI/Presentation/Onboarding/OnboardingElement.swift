//
//  OnboardingElement.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

enum OnboardingElement {
    case first
    case second
    case third

    var image: UIImage {
        switch self {
        case .first:
            return Assets.Images.Onboarding.onboardingPictureFirst.image
        case .second:
            return Assets.Images.Onboarding.onboardingPictureSecond.image
        case .third:
            return Assets.Images.Onboarding.onboardingPictureThird.image
        }
    }

    var buttonImage: UIImage {
        switch self {
        case .first:
            return Assets.Images.Onboarding.onboardingButtonFirst.image
        case .second:
            return Assets.Images.Onboarding.onboardingButtonSecond.image
        case .third:
            return Assets.Images.Onboarding.onboardingButtonThird.image
        }
    }

    var titleText: String {
        switch self {
        case .first:
            return LocalizedStrings.firtstOnboardingTitle
        case .second:
            return LocalizedStrings.secondOnboardingTitle
        case .third:
            return LocalizedStrings.thirdOnboardingTitle
        }
    }

    var text: String {
        switch self {
        case .first:
            return LocalizedStrings.firtstOnboardingText
        case .second:
            return LocalizedStrings.secondOnboardingText
        case .third:
            return LocalizedStrings.thirdOnboardingText
        }
    }
}
