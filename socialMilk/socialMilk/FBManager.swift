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
        log.logIn([.publicProfile, .userFriends, .email, .custom("user_managed_groups")], viewController: vc, completion: { loginResult in
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
    
    
    class func getUserGroups(callback: @escaping (_ groups: [FBChooseGroupClass]?) -> Void){
        let connection = GraphRequestConnection()
        var groups = [FBChooseGroupClass]()
        connection.add(GraphRequest(graphPath: "/me/groups",
                                    parameters: ["fields": "id, name, icon, cover, privacy, description"],
                                    accessToken: AccessToken.current,
                                    httpMethod: .GET,
                                    apiVersion: GraphAPIVersion.defaultVersion)){ httpResponse, result in
            switch result {
            case .success(let resp):
                let json = JSON(resp.dictionaryValue!)
                for group in json["data"].arrayValue{
                    groups.append(FBChooseGroupClass(title: group["name"].stringValue,
                                                     id: group["id"].stringValue,
                                                     photoLink: group["cover"]["source"].stringValue,
                                                     description: group["description"].stringValue))
                }
                callback(groups)
            case .failed(let error):
                print("Graph Request Failed: \(error)")
                callback(nil)
            }
            
        }
        connection.start()
    }
    
    class func getFeedByGroup(group: FBChooseGroupClass, callback: @escaping (_ posts: [FBPost]?) -> Void){
        let connection = GraphRequestConnection()
        connection.add(GraphRequest(graphPath: "/\(group.id)/feed",
                                    parameters: ["fields": "link, id, story, updated_time, attachments, message, permalink_url"],
                                    accessToken: AccessToken.current,
                                    httpMethod: .GET,
                                    apiVersion: GraphAPIVersion.defaultVersion)){ httpResponse, result in
                                        switch result {
                                        case .success(let resp):
                                            let json = JSON(resp.dictionaryValue!)
                                            var posts = [FBPost]()
                                            for post in json["data"].arrayValue{
                                                var text = ""
                                                if post["story"].stringValue == ""{
                                                    text = post["message"].stringValue
                                                }else if post["story"].stringValue == ""{
                                                    text = post["story"].stringValue
                                                }else{
                                                    text = post["story"].stringValue + "\n" + post["message"].stringValue
                                                }
                                                posts.append(FBPost(group: group,
                                                                    text: text,
                                                                    date: WorkingFB.translateFBTimeToUnix(time: post["updated_time"].stringValue),
                                                                    id: post["id"].stringValue,
                                                                    url: post["permalink_url"].stringValue,
                                                                    hasLink: false, // <-- temporary
                                                                    hasPhoto: false,
                                                                    hasVideo: false,
                                                                    linkLink: "",
                                                                    photoLink: "",
                                                                    videoLink: ""))
                                            }
                                            callback(posts)
                                        case .failed(let error):
                                            print("Graph Request Failed: \(error)")
                                            callback(nil)
                                        }
                                        
        }
        connection.start()
    }
    
}
