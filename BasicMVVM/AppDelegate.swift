//
//  AppDelegate.swift
//  BasicMVVM
//
//  Created by 김동준 on 2020/11/09.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        
        let nav = UINavigationController()
        window?.rootViewController = nav
        window?.rootViewController = SplashViewController()
        
        let tabBarController = UITabBarController()
        nav.pushViewController(tabBarController, animated: true)
        
        nav.modalPresentationStyle = .fullScreen
        
        let homeViewController = HomeViewController()
        tabBarController.addChild(homeViewController)
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: UIImage(), tag: 0)
        let reviewPage = ReviewPagerViewController()
        tabBarController.addChild(reviewPage)
        reviewPage.tabBarItem = UITabBarItem(title: "시술후기", image: UIImage(), tag: 1)
        
        return true
    }


}

