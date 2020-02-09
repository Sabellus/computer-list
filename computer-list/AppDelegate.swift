//
//  AppDelegate.swift
//  computer-list
//
//  Created by Савелий Вепрев on 01.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let navBar = UINavigationController()
        let builder = Builder()
        let router = Router(navigationController: navBar, builder: builder)   
        router.initialViewController()
        window?.rootViewController = navBar
        window?.makeKeyAndVisible()
        return true
    }
}

