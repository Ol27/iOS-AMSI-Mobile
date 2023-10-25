//
//  AppDelegate.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import GoogleMaps
import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinatorProtocol?

    func application(_: UIApplication,
                     didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        let navigationController: UINavigationController = .init()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        setupAppearances()
        setupApiKeys()
        return true
    }

    private func setupAppearances() {
        UINavigationBar.appearance().barTintColor = .black
        UITableView.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UICollectionView.appearance().backgroundColor = .clear
    }

    private func setupApiKeys() {
        GMSServices.provideAPIKey(ApiKeys.googleMapsKey)
    }
}
