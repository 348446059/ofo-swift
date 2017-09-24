//
//  AppDelegate.swift
//  Samoff
//
//  Created by libo on 2017/9/10.
//  Copyright © 2017年 libo. All rights reserved.
//

import UIKit
import AVOSCloud
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AMapServices.shared().apiKey = "f95022a86354db0d8e8d856aabf27636"
         AMapServices.shared().enableHTTPS = true
        
        AVOSCloud.setApplicationId("logANsPjRSX6ISGPHal4urFM-gzGzoHsz",clientKey:"njLxczcXyeLHCcuOwLYwHN3m")
        return true
    }
  /*  __                        ________                __
    / /   ___  ____ _____     / ____/ /___  __  ______/ /
    / /   / _ \/ __ `/ __ \   / /   / / __ \/ / / / __  /
    / /___/  __/ /_/ / / / /  / /___/ / /_/ / /_/ / /_/ /
    /_____/\___/\__,_/_/ /_/   \____/_/\____/\__,_/\__,_/
 */
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


}

