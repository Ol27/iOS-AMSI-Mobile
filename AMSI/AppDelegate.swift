//
//  AppDelegate.swift
//  AMSI
//
//  Created by Anton Petrov on 09.10.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        mainCoordinator = MainCoordinator(window: window)
        mainCoordinator?.start()
        return true
    }
}
