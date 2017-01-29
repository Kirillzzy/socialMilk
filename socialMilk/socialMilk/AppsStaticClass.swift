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
        addFBToAvailableApps()
        addTemplates()
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
            apps.append(allAvailableApps[3])
        }
        apps.append(allAvailableApps[4])
        apps.append(allAvailableApps[5])
        apps.append(allAvailableApps[6])
        apps.append(allAvailableApps[7])
        apps.append(allAvailableApps[8])
        apps.append(allAvailableApps[9])
    }
    
    private class func addSoonApps(){
        soonApps.append((#imageLiteral(resourceName: "instagramLogo"), NSLocalizedString("Insta", comment: "InstagramInscription")))
        soonApps.append((#imageLiteral(resourceName: "mail"), NSLocalizedString("Mail", comment: "MailInscription")))
        soonApps.append((#imageLiteral(resourceName: "linkedInlogoBig"), NSLocalizedString("LinkedIn", comment: "LinkedInInscription")))
        soonApps.append((#imageLiteral(resourceName: "snapchatLogoBig"), NSLocalizedString("SnapChat", comment: "SnapChatInscription")))
        soonApps.append((#imageLiteral(resourceName: "g+LogoBig"), NSLocalizedString("Google", comment: "Google+Inscription")))
        soonApps.append((#imageLiteral(resourceName: "slackLogoBig"), NSLocalizedString("Slack", comment: "SlackInscription")))
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
                             AppTag: 1,
                             AppName: NSLocalizedString("VK", comment: "VKInscription")))
    }
    
    private class func addFBToAvailableApps(){
        allAvailableApps.append(AppClass(AppManager: FBManager(),
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: FBChooseGroupClass(),
                                         AppPost: FBPost(),
                                         AppPostRealm: FBPostRealm(),
                                         AppCheckedPost: FBCheckedPost(),
                                         AppCheckedPostRealm: FBCheckedPostRealm(),
                                         AppRealmManager: RealmManagerFB(),
                                         AppWorking: WorkingFB(),
                                         AppIcon: #imageLiteral(resourceName: "facebookLogoBig"),
                                         AppTag: 3,
                                         AppName: NSLocalizedString("FB", comment: "FBInscription")))
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
                             AppTag: 2,
                             AppName: NSLocalizedString("Twitter", comment: "TwitterInscription")))

        
    }
    
    private class func addTemplates(){
        allAvailableApps.append(AppClass(AppManager: nil,
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: nil,
                                         AppPost: nil,
                                         AppPostRealm: nil,
                                         AppCheckedPost: nil,
                                         AppCheckedPostRealm: nil,
                                         AppRealmManager: nil,
                                         AppWorking: nil,
                                         AppIcon: #imageLiteral(resourceName: "instagramLogoBig"),
                                         AppTag: nil,
                                         AppName: NSLocalizedString("Insta", comment: "InstagramInscription")))
        
        allAvailableApps.append(AppClass(AppManager: nil,
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: nil,
                                         AppPost: nil,
                                         AppPostRealm: nil,
                                         AppCheckedPost: nil,
                                         AppCheckedPostRealm: nil,
                                         AppRealmManager: nil,
                                         AppWorking: nil,
                                         AppIcon: #imageLiteral(resourceName: "mail"),
                                         AppTag: nil,
                                         AppName: NSLocalizedString("Mail", comment: "MailInscription")))
        
        allAvailableApps.append(AppClass(AppManager: nil,
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: nil,
                                         AppPost: nil,
                                         AppPostRealm: nil,
                                         AppCheckedPost: nil,
                                         AppCheckedPostRealm: nil,
                                         AppRealmManager: nil,
                                         AppWorking: nil,
                                         AppIcon: #imageLiteral(resourceName: "linkedInlogoBig"),
                                         AppTag: nil,
                                         AppName: NSLocalizedString("LinkedIn", comment: "LinkedInInscription")))
        
        allAvailableApps.append(AppClass(AppManager: nil,
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: nil,
                                         AppPost: nil,
                                         AppPostRealm: nil,
                                         AppCheckedPost: nil,
                                         AppCheckedPostRealm: nil,
                                         AppRealmManager: nil,
                                         AppWorking: nil,
                                         AppIcon: #imageLiteral(resourceName: "snapchatLogoBig"),
                                         AppTag: nil,
                                         AppName: NSLocalizedString("SnapChat", comment: "SnapChatInscription")))
        
        allAvailableApps.append(AppClass(AppManager: nil,
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: nil,
                                         AppPost: nil,
                                         AppPostRealm: nil,
                                         AppCheckedPost: nil,
                                         AppCheckedPostRealm: nil,
                                         AppRealmManager: nil,
                                         AppWorking: nil,
                                         AppIcon: #imageLiteral(resourceName: "g+LogoBig"),
                                         AppTag: nil,
                                         AppName: NSLocalizedString("Google", comment: "Google+Inscription")))
        allAvailableApps.append(AppClass(AppManager: nil,
                                         AppManagerSide: nil,
                                         AppChooseGroupClass: nil,
                                         AppPost: nil,
                                         AppPostRealm: nil,
                                         AppCheckedPost: nil,
                                         AppCheckedPostRealm: nil,
                                         AppRealmManager: nil,
                                         AppWorking: nil,
                                         AppIcon: #imageLiteral(resourceName: "slackLogoBig"),
                                         AppTag: nil,
                                         AppName: NSLocalizedString("Slack", comment: "SlackInscription")))

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
                             AppTag: 0,
                             AppName: NSLocalizedString("All", comment: "AllInscription")))
    }
    
}
