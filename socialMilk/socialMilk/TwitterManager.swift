//
//  TwitterManager.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import TwitterKit
import SwiftyJSON
import Alamofire

final class TwitterManager{
    static var userName: String = ""
    static var userID: String = ""
    
    class func login(){
        Twitter.sharedInstance().logIn { session, error in
            if (session != nil) {
                print("signed in as \(session!.userName)");
                userName = session!.userName
                userID = session!.userID
            } else {
                print("error: \(error?.localizedDescription)");
            }
        }
    }
    
}

