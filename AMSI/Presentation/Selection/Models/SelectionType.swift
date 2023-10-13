//
//  SelectionType.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import Foundation

enum SelectionType {
    case city(Int?)
    case country(Int?)

    var title: String {
        switch self {
        case .city:
            return LocalizedStrings.pickCity
        case .country:
            return LocalizedStrings.pickCountry
        }
    }

    var associatedValue: Int? {
        switch self {
        case let .city(value), let .country(value):
            return value
        }
    }

    var items: [String] {
        switch self {
        case .city:
            return CanCity.items
        case .country:
            return Country.items
        }
    }
}
