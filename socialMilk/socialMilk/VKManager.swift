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
    
    var groupsAndPeople = [ChooseGroupClass]()
    
    init(){
        VK.configure(withAppId: Constants.appId, delegate: self)
        VK.logIn()
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return [.offline, .notifications, .wall, .friends]
    }
    
    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        print("Autorized")
        //NotificationsGet()
        //NewsGet()
        GroupsPeopleGet()
    }
    
    func vkAutorizationFailedWith(error: AuthError) {
        
    }
    
    func vkDidUnauthorize() {

    }
    
    func vkShouldUseTokenPath() -> String? {
        return nil
    }
    
    func vkWillPresentView() -> UIViewController {
        return UIApplication.shared.delegate!.window!!.rootViewController!
    }
    
    static let sharedInstance: VKManager = {
        let instance = VKManager()
        return instance
    }()
    
    func NotificationsGet(){
        _ = VK.API.Notifications.get([
            .count: "30"
            ]).send(
            onSuccess:  { response in
                print(response)
        },
            onError: {
                error in print("SwiftyVK: NotificationsGet fail \n \(error)")
        })
        
    }
    
    func NewsGet(){
        _ = VK.API.NewsFeed.get().send(
                onSuccess:  { response in
                    print(response)
            },
                onError: {
                    error in print("SwiftyVK: NotificationsGet fail \n \(error)")
            })
    }
    
//    func getNameAndPhotoLink(user: ChooseGroupClass){
//        _ = VK.API.Users.get([
//            .user_ids: "1",
//            .fields: "photo_50"]).send(
//            onSuccess:  { response in
//                user.photoLink = response["photo_50"].stringValue
//                user.title = response["first_name"].stringValue + response["last_name"].stringValue
//        },
//            onError: {
//                error in print("SwiftyVK: FriendsGet fail \n \(error)")
//        })
//    }
    
    
    func GroupsPeopleGet(){
        /// ----- groups
        _ = VK.API.Groups.get().send(
            onSuccess:  { response in
                for group in response["items"].arrayValue{
                    self.groupsAndPeople.append(ChooseGroupClass(title: group["name"].stringValue,
                                                            photoLink: group["photo_50"].stringValue,
                                                            id: group["id"].stringValue))
                    //only IDS!
                }
        },
            onError: {
                error in print("SwiftyVK: GroupsGet fail \n \(error)")
        })
        
        
        //// -------- friends in friends
        _ = VK.API.Friends.get([
            .fields: "photo_50"
            ]).send(
            onSuccess:  { response in
                for group in response["items"].arrayValue{
                    self.groupsAndPeople.append(ChooseGroupClass(title: group["frist_name"].stringValue + group["last_name"].stringValue,
                                                                 photoLink: group["photo_50"].stringValue,
                                                                 id: group["id"].stringValue))
                }
        },
            onError: {
                error in print("SwiftyVK: FriendsGet fail \n \(error)")
        })
        
        
//        /// ------ friends requests
//        _ = VK.API.Friends.getRequests().send(
//                onSuccess:  { response in
//                    for group in response["mutual", "users"].arrayValue{
//                        let person: ChooseGroupClass
//                        person.id = group.stringValue
//                        self.getNameAndPhotoLink(user: person)
//                        self.groupsAndPeople.append(person)
//                        
//                    }
//            },
//                onError: {
//                    error in print("SwiftyVK: FriendsGet fail \n \(error)")
//            })
//        
//        
        
    }
    
}
