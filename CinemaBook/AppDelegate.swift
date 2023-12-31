//
//  AppDelegate.swift
//  CinemaBook
//
//  Created by dungtien on 7/9/23.
//  Copyright © 2023 dungtien. All rights reserved.
//

import UIKit
import Firebase
import GooglePlaces

protocol RestartApp {
    func restartApp()
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,RestartApp,UNUserNotificationCenterDelegate {

    var window: UIWindow?
    private let navigationController = UINavigationController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GMSPlacesClient.provideAPIKey("AIzaSyCKPMo2ytoB9Hxp687JTjDY5dv9r_HUouA")
        window = UIWindow(frame: UIScreen.main.bounds)
        navigationController.setViewControllers([SplachScreenViewController()], animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    //=======mo rinf=====
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        
        // change the root view controller to your specific view controller
        //        window.rootViewController = vc
        
        navigationController.setViewControllers([vc], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func restartApp() {
        //            if !UserDefaults.standard.bool(forKey: "New User") {UserDefaults.standard.set(true, forKey: "New User")}
        //            let isNewUser = UserDefaults.standard.bool(forKey: "New User")
        //            print(isNewUser) // It will keep say "true" even change to false in UserDefault
        //            if isNewUser == true {
        //                window?.rootViewController = ViewController()
        //            } else if versioncheck != "1.0.0.0" {
        //                window?.rootViewController = NewUpdate()
        //            } else {
        //                window?.rootViewController = MainView()
        //            }
        navigationController.setViewControllers([SplachScreenViewController()], animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    //=============

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if #available(iOS 14.0, *) {
            completionHandler([ .banner, .list, .sound])
        } else {
            // Fallback on earlier versions
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

///=========
    func resetApp() {
        UIApplication.shared.windows[0].rootViewController = UIStoryboard(
            name: "Main",
            bundle: nil
            ).instantiateInitialViewController()
    }
}

