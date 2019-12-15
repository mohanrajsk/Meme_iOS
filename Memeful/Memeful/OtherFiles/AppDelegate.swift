//
//  AppDelegate.swift
//  Memeful
//
//  Created by LKB-L-105 on 12/12/19.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Launch root view controller
        launchRootViewController()
        return true
        
    }

    public func launchRootViewController(_ startVC:[UIViewController] = []) {
        
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true

        // Check Logged In
        let defaults = UserDefaults.standard
        if (defaults.bool(forKey: LOGGED_IN)) {
            // Show Dashboard
            let landingPageVC = LandingPageVC(nibName: "LandingPageVC", bundle: nil)
            navigation.viewControllers = [landingPageVC]
        }
        else {
            // Show Login
            let signIn = SignInVC(nibName: "SignInVC", bundle: nil)
            navigation.viewControllers = [signIn]
        }
        window?.rootViewController = navigation

        
    }
    
}

