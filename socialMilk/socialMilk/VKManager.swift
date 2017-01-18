//
//  VKManager.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import SwiftyVK


class VKManager: VKDelegate{
    
    init(){
        VK.configure(withAppId: Constants.VKappID, delegate: self)
        VK.logIn()
    }
    
    internal func vkWillAuthorize() -> Set<VK.Scope> {
        return [.offline, .wall, .friends, .groups]
    }
    
    internal func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        print("Autorized")
        LoginViewController.loginedAt += 1
        VKManagerWorker.getMe()
    }
    
    internal func vkAutorizationFailedWith(error: AuthError) {
        print("Autorization failed with error: \n\(error)")
    }
    
    internal func vkDidUnauthorize() {
    }
    
    internal func vkShouldUseTokenPath() -> String? {
        return nil
    }
    
    internal func vkWillPresentView() -> UIViewController {
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    static let sharedInstance: VKManager = {
        let instance = VKManager()
        return instance
    }()
    
}
