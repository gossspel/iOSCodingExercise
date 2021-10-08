//
//  AppDelegate.swift
//  iOSCodingExercise
//
//  Created by Sunny Chan on 10/8/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        let vc = PanExampleVC()
        vc.view.backgroundColor = .white
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.isTranslucent = false
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        return true
    }
}

