//
//  Array+SafeElement.swift
//  AMSI
//
//  Created by Anton Petrov on 24.10.2023.
//

import Foundation

extension Array {
    func safeElement(at index: Index) -> Element? {
        guard indices.contains(index) else {
            return nil
        }
        return self[index]
    }
}
