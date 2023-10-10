//
//  MainTabViewController.swift
//  AMSI
//
//  Created by Anton Petrov on 10.10.2023.
//

import SnapKit
import UIKit

final class MainTabViewController: UIViewController {
    private let imageView = UIImageView().apply {
        $0.image = Assets.Images.Home.homeScreen.image
        $0.contentMode = .scaleAspectFill
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Assets.Colors.Shared.screenBackground.color
        hideNavigationBar()
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
