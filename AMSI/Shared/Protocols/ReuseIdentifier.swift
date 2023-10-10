//
//  ReuseIdentifier.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import Foundation

protocol ReuseIdentifier {}

extension ReuseIdentifier {
    static var reuseIdentifier: String {
        String(describing: Self.self)
    }
}
