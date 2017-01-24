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

    
    class func initial(){
        addAllAppsAppToAvailableApps()
        addVKToAvailableApps()
        addTwitterToAvailableApps()
        loadApps()
        addSoonApps()
    }
    
    class func loadApps(){
        apps.removeAll()
        apps.append(allAvailableApps[0])
        if WorkingDefaults.isHaveVk(){
            apps.append(allAvailableApps[1])
        }
        if WorkingDefaults.isHaveTwitter(){
            apps.append(allAvailableApps[2])
        }
        if WorkingDefaults.isHaveFb(){
//            addFBToApps()
        }
    }
    
    private class func addSoonApps(){
        soonApps.append((#imageLiteral(resourceName: "facebookLogoBig"), "Facebook"))
        soonApps.append((#imageLiteral(resourceName: "instagramLogo"), "Instagram"))
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
    
    private class func addAllAppsAppToAvailableApps(){
        allAvailableApps.append(AppClass(AppManager: nil,
                             AppManagerSide: nil,
                             AppChooseGroupClass: nil,
                             AppPost: nil,
                             AppPostRealm: nil,
                             AppCheckedPost: nil,
                             AppCheckedPostRealm: nil,
                             AppRealmManager: nil,
                             AppWorking: nil,
                             AppIcon: #imageLiteral(resourceName: "socialMediaFull"),
                             AppName: "All"))
    }
    
    private class func addFBToApps(){
        // in fututre
    }
    
}
