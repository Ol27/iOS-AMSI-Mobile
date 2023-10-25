//
//  StubViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 17.10.2023.
//

import SnapKit
import UIKit

class StubViewController: UIViewController {
    private let centeredLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        centeredLabel.text = String(describing: Self.self)
        setupUI()
    }

    private func setupUI() {
        view.addSubview(centeredLabel)
        centeredLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
