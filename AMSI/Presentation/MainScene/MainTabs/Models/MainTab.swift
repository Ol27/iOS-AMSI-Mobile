//
//  MainTab.swift
//  AMSI
//
//  Created by Anton Petrov on 16.10.2023.
//

import UIKit

enum TabItem: Int, CaseIterable {
    case home
    case events
    case search
    case jobs
    case profile

    var selectedImage: UIImage {
        switch self {
        case .home:
            return Assets.Images.MainTabBar.homeSelected.image
        case .events:
            return Assets.Images.MainTabBar.eventsSelected.image
        case .search:
            return Assets.Images.MainTabBar.searchSelected.image
        case .jobs:
            return Assets.Images.MainTabBar.jobsSelected.image
        case .profile:
            return Assets.Images.MainTabBar.profileSelected.image
        }
    }

    var unselectedImage: UIImage {
        switch self {
        case .home:
            return Assets.Images.MainTabBar.homeUnselected.image
        case .events:
            return Assets.Images.MainTabBar.eventsUnselected.image
        case .search:
            return Assets.Images.MainTabBar.searchUnselected.image
        case .jobs:
            return Assets.Images.MainTabBar.jobsUnselected.image
        case .profile:
            return Assets.Images.MainTabBar.profileUnselected.image
        }
    }

    var rootViewController: UIViewController {
        switch self {
        case .home:
            return HomeViewController()
        case .events:
            return EventsViewController()
        case .search:
            return SearchViewController()
        case .jobs:
            return JobsViewController()
        case .profile:
            return ProfileViewController()
        }
    }
}
