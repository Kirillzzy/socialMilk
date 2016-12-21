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
    
    
    class func loadFollowing(callback: @escaping (_ people: [TwitterChooseGroupClass]?) -> Void){
        var people = [TwitterChooseGroupClass]()
        let client = TWTRAPIClient.withCurrentUser()
        let statusesShowEndpoint = "https://api.twitter.com/1.1/friends/list.json"
        let cursor = -1
        let params = ["screen_name": userName,
                      "count": "200",
                      "cursor": "\(cursor)"]
        var clientError : NSError?
        let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if connectionError != nil {
                print("Error: \(connectionError)")
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let js = JSON(json)
                for person in js["users"].arrayValue{
                    people.append(TwitterChooseGroupClass(title: person["name"].stringValue,
                                                          photoLink: person["profile_image_url_https"].stringValue,
                                                          id: person["id"].stringValue,
                                                          description: person["description"].stringValue))
                }
                print("People recieved: \(people.count)")
                callback(people)
                
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
                callback(nil)
            }
        }


    }
    
}
