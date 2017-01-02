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
import SwiftyJSON


final class FBManager{
    static var userName: String = ""
    static var userId: String = ""
    
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
            case .success( _, _, _):
                print("Logged in!")
                LoginViewController.loginedAt += 1
                getMe()
            }
        })
    }
    
    
    class func getMe(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me",
                                    parameters: ["fields": "id, name, about"],
                                    accessToken: AccessToken.current,
                                    httpMethod: .GET,
                                    apiVersion: GraphAPIVersion.defaultVersion)){ httpResponse, result in
                                        switch result {
                                        case .success(let resp):
                                            userName = resp.dictionaryValue?["name"] as! String
                                            userId = resp.dictionaryValue?["id"] as! String
                                        case .failed(let error):
                                            print("Graph Request Failed: \(error)")
                                        }
                                        
        }
        connection.start()
    }
    
    
    ////// ---- dosent work ->(2 functions)
    class func getUserGroups(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/groups",
                                    parameters: ["fields": "id, cover, description"],
                                    accessToken: AccessToken.current,
                                    httpMethod: .GET,
                                    apiVersion: GraphAPIVersion.defaultVersion)){ httpResponse, result in
            switch result {
            case .success(let response):
                print(response)
                //print(response.dictionaryValue?["total_count"] as! String)
            case .failed(let error):
                print("Graph Request Failed: \(error)")
            }
            
        }
        connection.start()
    }
    
    class func getFeedByGroup(){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/me/groups/feed",
                                    parameters: ["fields": "id, cover, description"],
                                    accessToken: AccessToken.current,
                                    httpMethod: .GET,
                                    apiVersion: GraphAPIVersion.defaultVersion)){ httpResponse, result in
                                        switch result {
                                        case .success(let response):
                                            print(response)
                                        //print(response.dictionaryValue?["total_count"] as! String)
                                        case .failed(let error):
                                            print("Graph Request Failed: \(error)")
                                        }
                                        
        }
        connection.start()
    }
    
    //////// doesn't work until here!!
    
}
