//
//  Country.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import Foundation

enum Country: Int, CaseIterable, Selectable {
    case usa
    case can
    case gbr
    case aus

    var fullName: String {
        switch self {
        case .usa: return "United States of America"
        case .can: return "Canada"
        case .gbr: return "United Kingdom"
        case .aus: return "Australia"
        }
    }

    var cities: [Selectable] {
        switch self {
        case .usa:
            return UsaCity.allCases
        case .can:
            return CanCity.allCases
        case .gbr:
            return GbrCity.allCases
        case .aus:
            return AusCity.allCases
        }
    }
}
