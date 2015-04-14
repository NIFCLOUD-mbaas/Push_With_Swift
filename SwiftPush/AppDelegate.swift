//
//  AppDelegate.swift
//  SwiftPush
//
//  Created by Atsushi Nakatsugawa on 2015/04/14.
//  Copyright (c) 2015年 Atsushi Nakatsugawa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        NCMB.setApplicationKey("APPLICATION_KEY", clientKey: "CLIENT_KEY")
        if NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1 {
            //iOS8でのデバイストークン取得
            let userNotificationTypes = (UIUserNotificationType.Alert |
                UIUserNotificationType.Badge |
                UIUserNotificationType.Sound);
            
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        } else {
            //iOS7以前でのデバイストークン取得
            var types:UIRemoteNotificationType = UIRemoteNotificationType.Badge | UIRemoteNotificationType.Alert | UIRemoteNotificationType.Sound
            UIApplication.sharedApplication().registerForRemoteNotificationTypes(types)
        }
        
        // アプリ起動時のプッシュ通知
        if let remoteNotification = launchOptions?[UIApplicationLaunchOptionsRemoteNotificationKey] as? NSDictionary {
            println("Remote Notification \(remoteNotification)")
        }
        return true
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = NCMBInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock(nil) //必要があればBlock内でエラー処理を行う
    }
    
    // 起動中に受け取ったプッシュ通知
    func application(application: UIApplication, didReceiveRemoteNotification userInfo:[NSObject : AnyObject],
        fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void){
            println("User Info \(userInfo)")
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

