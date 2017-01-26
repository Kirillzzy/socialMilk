//
//  WorkingDefaults.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation


final class WorkingDefaults{
    private static let defaults = UserDefaults.standard
    
    private static let keyVK = "haveVK"
    private static let keyTwitter = "haveTwitter"
    private static let keyFB = "haveFacebook"
    private static let firstSetup = "isFirstSetupEver"
    private static let browserType = "browserType"
    
    enum Browser{
        case my
        case safari
    }
    
    class func isHaveVk() -> Bool{
        if WorkingDefaults.defaults.bool(forKey: WorkingDefaults.keyVK){
            return true
        }
        return false
    }
    
    class func isHaveTwitter() -> Bool{
        if WorkingDefaults.defaults.bool(forKey: WorkingDefaults.keyTwitter){
            return true
        }
        return false
    }
    
    class func isHaveFb() -> Bool{
        if WorkingDefaults.defaults.bool(forKey: WorkingDefaults.keyFB){
            return true
        }
        return false
    }
    
    class func setVK(how: Bool){
        WorkingDefaults.defaults.set(how, forKey: WorkingDefaults.keyVK)
    }
    
    class func setTwitter(how: Bool){
        WorkingDefaults.defaults.set(how, forKey: WorkingDefaults.keyTwitter)
    }
    
    class func setFB(how: Bool){
        WorkingDefaults.defaults.set(how, forKey: WorkingDefaults.keyFB)
    }
    
    class func isFirstSetupEver() -> Bool{
        if WorkingDefaults.defaults.object(forKey: WorkingDefaults.firstSetup) != nil{
            return false
        }
        return true
    }
    
    class func setFirstSetupEver(how: Bool){
        WorkingDefaults.defaults.set(how, forKey: firstSetup)
    }
    
    class func setBrowser(how: Browser){
        switch how{
            case Browser.my:
                WorkingDefaults.defaults.set("my", forKey: browserType)
            case Browser.safari:
                WorkingDefaults.defaults.set("safari", forKey: browserType)
        }
    }
    
    class func getBrowser() -> Browser{
        if let type = WorkingDefaults.defaults.string(forKey: browserType){
            if type == "safari"{
                return Browser.safari
            }
        }
        return Browser.my
    }
    
}
