//
//  FBManager.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 01/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin


final class FBManager{
    
    class func logout(){
        let log = LoginManager.init()
        log.logOut()
    }
    
    class func loginVc(vc: UIViewController){
        let log = LoginManager.init()
        log.logIn([.publicProfile, .userFriends, .email], viewController: vc, completion: { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
                LoginViewController.loginedAt += 1
            }
        })
    }
    
    
    class func getUserGroups(){
        let connection = GraphRequestConnection()
        
        connection.add(GraphRequest(graphPath: "/me",
                                    parameters: ["fields": "id, name, about"],
                                    accessToken: AccessToken.current,
                                    httpMethod: .GET,
                                    apiVersion: GraphAPIVersion.defaultVersion)){ httpResponse, result in
            switch result {
            case .success(let response):
            print("Graph Request Succeeded: \(response)")
            case .failed(let error):
            print("Graph Request Failed: \(error)")
            }
            
        }
        connection.start()
    }
    
}
