//
//  AppClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 31/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import UIKit


class AppClass{
    
    var AppManager: Any!
    var AppManagerSide: Any?
    var AppChooseGroupClass: Any!
    var AppPost: Any!
    var AppPostRealm: Any!
    var AppCheckedPost: Any!
    var AppCheckedPostRealm: Any!
    var AppRealmManager: Any!
    var AppWorking: Any!
    var AppIcon: UIImage!
    var AppName: String!
    
    init(AppManager: Any!, AppManagerSide: Any?, AppChooseGroupClass: Any!,
         AppPost: Any!, AppPostRealm: Any!,
         AppCheckedPost: Any!, AppCheckedPostRealm: Any!,
         AppRealmManager: Any!, AppWorking: Any!,
         AppIcon: UIImage, AppName: String){
        
        self.AppManager = AppManager
        self.AppManagerSide = AppManagerSide
        self.AppChooseGroupClass = AppChooseGroupClass
        self.AppPost = AppPost
        self.AppPostRealm = AppPostRealm
        self.AppCheckedPost = AppCheckedPost
        self.AppCheckedPostRealm = AppCheckedPostRealm
        self.AppRealmManager = AppRealmManager
        self.AppWorking = AppWorking
        self.AppIcon = AppIcon
        self.AppName = AppName
    }
    
    init(){}
    
}
