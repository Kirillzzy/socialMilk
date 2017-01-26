//
//  WorkingFB.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

class WorkingFB{
    
    static var sources = [FBCheckedPost]()
    
    static func updateSources(){
        RealmManagerFB.deleteFBCheckedPosts()
        for post in sources{
            RealmManagerFB.saveNewCheckedPost(post: RealmManagerFB.encodeFBCheckedPostToRealm(post: post))
        }
    }
    
    static func translateFBTimeToUnix(time: String) -> String{
        let dateFormatter = DateFormatter()
        let times = time.replacingOccurrences(of: "T", with: " ")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date: Date = dateFormatter.date(from: times)!
        return String(Int(date.timeIntervalSince1970))
    }
    
    static func checkNewPosts() -> [FBPost]{
        var lastPosts: [FBPost] = [FBPost]()
        var count = 0
        for source in sources{
            FBManager.getFeedByGroup(group: source.group, callback: { posts in
                if posts != nil{
                    var pos = posts!
                    pos.sort(by: {post1, post2 in Int(post1.date)! > Int(post2.date)!})
                    if source.lastCheckedPostId != "0"{
                        for post in pos{
                            if post.id == source.lastCheckedPostId{
                                break
                            }
                            lastPosts.append(post)
                        }
                    }
                    if pos.count > 0{
                        RealmManagerFB.updateFBCheckedPost(post: RealmManagerFB.encodeFBCheckedPostToRealm(post: source),
                                                           newLastCheckedPostId: pos[0].id,
                                                           newGroupTitle: source.group.title,
                                                           newGroupPhotoLink: source.group.photoLink,
                                                           newGroupId: source.group.id,
                                                           newGroupDescription: source.group.description,
                                                           newGroupScreenName: source.group.screenName)
                        
                        source.lastCheckedPostId = pos[0].id
                    }
                }
                count += 1
            })
        }
        while(count != sources.count){}
        for post in lastPosts{
            RealmManagerFB.saveNewFBPost(post: RealmManagerFB.encodeFBPostToRealm(post: post))
        }
        lastPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return lastPosts
    }
    
    
    static func getOldPosts() -> [FBPost]{
        let oldRealmPosts = RealmManagerFB.getFBPosts()
        var oldPosts = [FBPost]()
        for post in oldRealmPosts{
            oldPosts.append(RealmManagerFB.encodeRealmFBPostToJust(post: post))
        }
        oldPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return oldPosts
    }

    static func getPosts() -> [FBPost]{
        var oldPosts = getOldPosts()
        oldPosts.append(contentsOf: checkNewPosts())
        oldPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return oldPosts
    }
    
    static func encodePostsToMessages(posts: [FBPost]) -> [MessageClass]{
        var mess = [MessageClass]()
        for post in posts{
            let message = MessageClass(head: post.group.title,
                                       message: post.text,
                                       timeNSDate: WorkingVk.translateUnixTime(time: Int(post.date)!),
                                       url: post.url,
                                       postFb: post)
            
            mess.append(message)
        }
        return mess
    }
    
    
    static func createChatByMessages() -> [MessageClass]{
        return encodePostsToMessages(posts: getPosts())
    }

}
