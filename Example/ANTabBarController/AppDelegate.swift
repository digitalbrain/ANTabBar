//
//  AppDelegate.swift
//  ANTabBarController
//
//  Created by Digitalbrain on 09/16/2019.
//  Copyright (c) 2019 Digitalbrain. All rights reserved.
//

import UIKit
import ANTabBarController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var tabBarCotnroller: ANTabBarController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.tabBarCotnroller = ANTabBarController.create()
               self.window?.rootViewController = self.tabBarCotnroller
               self.window?.makeKeyAndVisible()


               let vc1 = ViewController()
               let vc2 =  UIViewController()
               let vc3 =  UIViewController()
               let vc4 =  UIViewController()
        let color = #colorLiteral(red: 0.7450980392, green: 0.1176470588, blue: 0.1803921569, alpha: 1)
        
        let ico1 = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        let ico2 = UIImage(named: "notification")?.withRenderingMode(.alwaysTemplate)
        let ico3 = UIImage(named: "star")?.withRenderingMode(.alwaysTemplate)
        let ico4 = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        if #available(iOS 13.0, *) {
            
            self.tabBarCotnroller?.add(viewController: vc1, item: ANTabBarItem.create(title: "Home", icon: ico1, defaultColor: .white, selectedColor: color))
            self.tabBarCotnroller?.add(viewController: vc2, item: ANTabBarItem.create(title: "Notifiche", icon: ico2, defaultColor: .white, selectedColor: color))
            self.tabBarCotnroller?.add(viewController: vc3, item: ANTabBarItem.create(title: "Preferiti", icon: ico3, defaultColor: .white, selectedColor: color))
            self.tabBarCotnroller?.add(viewController: vc4, item: ANTabBarItem.create(title: "Impostazioni", icon: ico4, defaultColor: .white, selectedColor: color))
        }
        
        return true
          
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

