//
//  AppsStaticClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 14/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation


final class AppsStaticClass{
    static var apps = [AppClass]()
    static var allAvailableApps = [AppClass]()
    static var soonApps = [(UIImage, String)]()
    private static let defaults = UserDefaults.standard
    static let keyVK = "haveVK"
    static let keyTwitter = "haveTwitter"
    static let keyFB = "haveFB"

    
    class func initial(){
        addVKToAvailableApps()
        addTwitterToAvailableApps()
        loadApps()
        addSoonApps()
    }
    
    class func loadApps(){
        apps.removeAll()
        if defaults.bool(forKey: keyVK){
            apps.append(allAvailableApps[0])
        }
        if defaults.bool(forKey: keyTwitter){
            apps.append(allAvailableApps[1])
        }
        if defaults.bool(forKey: keyFB){
//            addFBToApps()
        }
    }
    
    private class func addSoonApps(){
        soonApps.append((#imageLiteral(resourceName: "facebookLogoBig"), "Facebook"))
        soonApps.append((#imageLiteral(resourceName: "instagramLogo"), "Instagram"))
    }
    
    class func saveVK(how: Bool){
        defaults.set(how, forKey: keyVK)
        loadApps()
    }
    
    class func saveTwitter(how: Bool){
        defaults.set(how, forKey: keyTwitter)
        loadApps()
    }
    
    private class func saveFB(how: Bool){
        defaults.set(how, forKey: keyFB)
        loadApps()
    }
    
    private class func addVKToAvailableApps(){
        allAvailableApps.append(AppClass(AppManager: VKManager(),
                             AppManagerSide: VKManagerWorker(),
                             AppChooseGroupClass: VKChooseGroupClass(),
                             AppPost: VKPost(),
                             AppPostRealm: VKPostRealm(),
                             AppCheckedPost: VKCheckedPost(),
                             AppCheckedPostRealm: VKCheckedPostRealm(),
                             AppRealmManager: RealmManagerVk(),
                             AppWorking: WorkingVk(),
                             AppIcon: #imageLiteral(resourceName: "vkLogoBlackBig"),
                             AppName: "VK"))
    }
    
    private class func addTwitterToAvailableApps(){
        allAvailableApps.append(AppClass(AppManager: TwitterManager(),
                             AppManagerSide: nil,
                             AppChooseGroupClass: TwitterChooseGroupClass(),
                             AppPost: TweetPost(),
                             AppPostRealm: TweetPostRealm(),
                             AppCheckedPost: TweetCheckedPost(),
                             AppCheckedPostRealm: TweetCheckedPostRealm(),
                             AppRealmManager: RealmManagerTwitter(),
                             AppWorking: WorkingTwitter(),
                             AppIcon: #imageLiteral(resourceName: "twitterLogo"),
                             AppName: "Twitter"))
    }
    
    private class func addFBToApps(){
        // in fututre
    }
    
}
