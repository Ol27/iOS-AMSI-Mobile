//
//  AddressData.swift
//  AMSI
//
//  Created by Anton Petrov on 12.10.2023.
//

import Foundation

enum AddressData: Int, CaseIterable {
    case addressLineOne
    case addressLineTwo
    case country
    case city
    case zipCode

    var placeholder: String {
        switch self {
        case .addressLineOne:
            return LocalizedStrings.addressLineOne
        case .addressLineTwo:
            return LocalizedStrings.addressLineTwo
        case .country:
            return LocalizedStrings.countryLine
        case .city:
            return LocalizedStrings.cityLine
        case .zipCode:
            return LocalizedStrings.zipCodeLine
        }
    }

    var shouldBePicked: Bool {
        switch self {
        case .city, .country:
            return true
        default:
            return false
        }
    }
}
