//
//  AppDelegate.swift
//  TMDbAPI
//
//  Created by Fatma Demirci on 15.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]

        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -900, vertical: 0), for:UIBarMetrics.default)

        window = UIWindow(frame: UIScreen.main.bounds)
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        let nav = UINavigationController(rootViewController: mainVC)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }


}

