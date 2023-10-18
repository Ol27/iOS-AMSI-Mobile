//
//  City.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import Foundation

enum UsaCity: Int, CaseIterable, Selectable {
    case newYork
    case losAngeles
    case chicago
    case houston
    case miami

    var fullName: String {
        switch self {
        case .newYork: return "New York"
        case .losAngeles: return "Los Angeles"
        case .chicago: return "Chicago"
        case .houston: return "Houston"
        case .miami: return "Miami"
        }
    }
}

enum CanCity: Int, CaseIterable, Selectable {
    case toronto
    case vancouver
    case montreal
    case calgary
    case edmonton

    var fullName: String {
        switch self {
        case .toronto: return "Toronto"
        case .vancouver: return "Vancouver"
        case .montreal: return "Montreal"
        case .calgary: return "Calgary"
        case .edmonton: return "Edmonton"
        }
    }
}

enum GbrCity: Int, CaseIterable, Selectable {
    case london
    case manchester
    case birmingham
    case liverpool
    case edinburgh

    var fullName: String {
        switch self {
        case .london: return "London"
        case .manchester: return "Manchester"
        case .birmingham: return "Birmingham"
        case .liverpool: return "Liverpool"
        case .edinburgh: return "Edinburgh"
        }
    }
}

enum AusCity: Int, CaseIterable, Selectable {
    case sydney
    case melbourne
    case brisbane
    case perth
    case adelaide

    var fullName: String {
        switch self {
        case .sydney: return "Sydney"
        case .melbourne: return "Melbourne"
        case .brisbane: return "Brisbane"
        case .perth: return "Perth"
        case .adelaide: return "Adelaide"
        }
    }
}
