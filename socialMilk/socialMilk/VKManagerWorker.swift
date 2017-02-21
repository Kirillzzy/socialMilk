//
//  VKManagerWorker.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 12/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import SwiftyVK


final class VKManagerWorker{
    
    static var userName: String = ""
    static var userID: String = ""
    
    class func authorize() {
        VK.logOut()
        print("SwiftyVK: LogOut")
        VK.logIn()
        print("SwiftyVK: authorize")
    }
    
    class func checkState() -> VK.States{
        return VK.state
    }

    
    class func logout() {
        VK.logOut()
        print("SwiftyVK: LogOut")
    }    
    
    class func getMe(){
        _ = VK.API.Users.get().send(
            onSuccess: {
                response in
                self.userName = response[0, "first_name"].stringValue + " " + response[0, "last_name"].stringValue
                self.userID = response[0, "id"].stringValue
        },
            onError: {
                error in print("SwiftyVK: GetMe fail \n \(error)")
        })
    }
    
    
    
}
