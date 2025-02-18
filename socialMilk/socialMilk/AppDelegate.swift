//
//  AppDelegate.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SwiftyVK
import Fabric
import TwitterKit
import FacebookLogin
import FacebookCore
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookShare
import FBSDKShareKit
import SafariServices

var vkDelegateReference: VKDelegate?

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let appl = options[.sourceApplication] as? String
        VK.process(url: url, sourceApplication: appl)
        //return true
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url as URL!, sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as! String, annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Call the 'activate' method to log an app event for use
        // in analytics and advertising reporting.
        AppEventsLogger.activate(application)
        // ...
    }

    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VK.process(url: url, sourceApplication: sourceApplication)
        return true
    }
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Fabric.with([Twitter.self])
        Init.Init()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

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
        FBSDKAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

func showBrowser(view: UIViewController, url: URL) {
  if WorkingDefaults.getBrowser() == WorkingDefaults.Browser.my {
    let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    view.present(svc, animated: true, completion: nil)
  } else {
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(url, options: [:])
    } else {
      UIApplication.shared.openURL(url)
    }
  }
}

