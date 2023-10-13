//
//  Selectable.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import Foundation

protocol Selectable {
    var identifier: Int { get }
    var fullName: String { get }
    static var items: [String] { get }
}

extension Selectable where Self: RawRepresentable, Self: CaseIterable, Self.RawValue == Int {
    var identifier: Int {
        rawValue
    }

    static var items: [String] {
        allCases.map { $0.fullName }
    }
}
