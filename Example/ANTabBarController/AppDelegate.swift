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
    
    var tabBarCotnroller: AppTabBarController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.tabBarCotnroller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppTabBarController") as? AppTabBarController
        
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
            self.tabBarCotnroller?.add(viewController: vc2, item: ANTabBarItem.create(title: "Notifiche", icon: ico2, defaultColor: .white, selectedColor: .black))
            self.tabBarCotnroller?.add(viewController: vc3, item: ANTabBarItem.create(title: "Preferiti", icon: ico3, defaultColor: .white, selectedColor: color))
            self.tabBarCotnroller?.add(viewController: vc4, item: ANTabBarItem.create(title: "Impostazioni", icon: ico4, defaultColor: .white, selectedColor: color))
            self.tabBarCotnroller?.add(viewController: vc4, item: ANTabBarItem.create(title: "Impostazioni", icon: ico4, defaultColor: .white, selectedColor: color))
        }
        
        return true
          
    }

}

