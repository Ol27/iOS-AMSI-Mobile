//
//  Applyable.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import Foundation

protocol Applyable {}

extension Applyable where Self: AnyObject {
    @discardableResult
    func apply(_ item: (Self) throws -> Void) rethrows -> Self {
        try item(self)
        return self
    }
}

extension NSObject: Applyable {}
