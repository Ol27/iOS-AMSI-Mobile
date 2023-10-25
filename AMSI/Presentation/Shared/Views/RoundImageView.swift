//
//  RoundImageView.swift
//  AMSI
//
//  Created by Anton Petrov on 13.10.2023.
//

import UIKit

final class RoundImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.masksToBounds = true
    }
}
