//
//  FillDataStep.swift
//  AMSI
//
//  Created by Anton Petrov on 12.10.2023.
//

import UIKit

enum FillDataStep {
    case addPhoto
    case contactInfo
    case address

    var iconImage: UIImage {
        switch self {
        case .addPhoto:
            return Assets.Images.FillData.addPhotoIcon.image
        case .contactInfo:
            return Assets.Images.FillData.contactInfoIcon.image
        case .address:
            return Assets.Images.FillData.addressIcon.image
        }
    }

    var titleText: String {
        switch self {
        case .addPhoto:
            return LocalizedStrings.addPhotoTitle
        case .contactInfo:
            return LocalizedStrings.contactInfoTitle
        case .address:
            return LocalizedStrings.addressTitle
        }
    }

    var pageControlImage: UIImage {
        switch self {
        case .addPhoto:
            return Assets.Images.FillData.pageOne.image
        case .contactInfo:
            return Assets.Images.FillData.pageTwo.image
        case .address:
            return Assets.Images.FillData.pageThree.image
        }
    }
}
