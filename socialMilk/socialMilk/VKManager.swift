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
        VK.configure(withAppId: Constants.appId, delegate: self)
        VK.logIn()
    }
    
    func vkWillAuthorize() -> Set<VK.Scope> {
        return [.offline, .notifications, .wall, .friends]
    }
    
    func vkDidAuthorizeWith(parameters: Dictionary<String, String>) {
        print("Autorized")
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
                    error in print("SwiftyVK: NewsGet fail \n \(error)")
            })
    }
    
    func getNameAndPhotoLink(user: ChooseGroupClass){
        _ = VK.API.Users.get([
            .userIDs: "\(user.id)",
            .fields: "photo_100"]).send(
            onSuccess:  { response in
                user.photoLink = response["photo_100"].stringValue
                user.title = response["first_name"].stringValue +  " " + response["last_name"].stringValue
        },
            onError: {
                error in print("SwiftyVK: FriendsGet fail \n \(error)")
        })
    }
    
    
    
    func getNameAndPhotoLinkGroup(groups: [ChooseGroupClass]){
        var strGroups = ""
        for group in groups{
            strGroups += group.id + ","
        }
        _ = VK.API.Groups.getById([
            .groupIds: strGroups]).send(
                onSuccess:  { response in
                    var ch = 0
                    for group in response.arrayValue{
                        groups[ch].photoLink = group["photo_100"].stringValue
                        groups[ch].title = group["name"].stringValue
                        ch += 1
                    }
            },
                onError: {
                    error in print("SwiftyVK: GroupsPhotoGet fail \n \(error)")
            })
    }
    
    
    
    func GroupsPeopleGet() -> [ChooseGroupClass]{
        var groupsAndPeople = [ChooseGroupClass]()
        var status = false
        /// ----- groups
        _ = VK.API.Groups.get().send(
            onSuccess:  { response in
                var groups = [ChooseGroupClass]()
                for group in response["items"].arrayValue{
                    let person = ChooseGroupClass()
                    person.id = group.stringValue
                    groupsAndPeople.append(person)
                    groups.append(person)
                }
                self.getNameAndPhotoLinkGroup(groups: groups)
        },
            onError: {
                error in print("SwiftyVK: GroupsGet fail \n \(error)")
        })
        
        
        //// -------- friends in friends
        _ = VK.API.Friends.get([
            .fields: "photo_100"
            ]).send(
            onSuccess:  { response in
                for group in response["items"].arrayValue{
                    groupsAndPeople.append(ChooseGroupClass(title: group["first_name"].stringValue + " " + group["last_name"].stringValue,
                                                                 photoLink: group["photo_100"].stringValue,
                                                                 id: group["id"].stringValue, isGroup: false))
                }
                
                status = true
        },
            onError: {
                error in print("SwiftyVK: FriendsGet fail \n \(error)")
                status = true
        })
        
        while(!status){}
        return groupsAndPeople
    }
    
    
    func WallGet(group: ChooseGroupClass) -> [VKPost]{
        var posts = [VKPost]()
        var status = false
        var id = group.id
        if group.isGroup{
            id = "-" + id
        }
        _ = VK.API.Wall.get([
            VK.Arg.ownerId: "\(id)",
            VK.Arg.count: "100"]).send(
                onSuccess:  { response in
                    for post in response["items"].arrayValue{
                        var hasLink = false
                        var hasVideo = false
                        for att in post["attachments"].arrayValue{
                            if att["type"].stringValue == "video"{
                                hasVideo = true
                            }
                            if att["type"].stringValue == "link"{
                                hasLink = true
                            }
                        }
                        
                        posts.append(VKPost(id: post["id"].stringValue,
                                            text: post["text"].stringValue,
                                            date: post["date"].stringValue,
                                            group: group,
                                            hasLink: hasLink,
                                            hasVideo: hasVideo))
                    }
                    status = true
            },
                onError: {
                    error in print("SwiftyVK: WallGet fail \n \(error)")
                    status = true
            })
    
        while(!status){}
        return posts

    }
    
}
