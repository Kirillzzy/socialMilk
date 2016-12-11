//
//  WorkingVk.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 04/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


final class WorkingVk{
    static var sources = [VKCheckedPost]()
    private static let vk = VKManager.sharedInstance
    
    
    static func updateSources(){
        RealmManagerVk.deleteVKCheckedPosts()
        for post in sources{
            RealmManagerVk.saveNewCheckedPost(post: RealmManagerVk.encodeVKCheckedPostToRealm(post: post))
        }
    }
    
    static func translateUnixTime(time: Int) -> NSDate{
        return NSDate(timeIntervalSince1970: TimeInterval(time))
    }
    
    static func translateNSDateToString(date: NSDate) -> String{
        let calendar = NSCalendar.current
        var hour = String(calendar.component(.hour, from: date as Date))
        var minutes = String(calendar.component(.minute, from: date as Date))
        if hour.characters.count == 1{
            hour = "0" + hour
        }
        if minutes.characters.count == 1{
            minutes = "0" + minutes
        }
        return String(hour + ":" + minutes)
    }
    
    static func checkNewPosts() -> [VKPost]{
        var lastPosts: [VKPost] = [VKPost]()
        for source in sources{
            var posts = vk.WallGet(group: source.group)
            posts.sort(by: {post1, post2 in Int(post1.date)! > Int(post2.date)!})
            if source.lastCheckedPostId != "0"{
                for post in posts{
                    if post.id == source.lastCheckedPostId{
                        break
                    }
                    lastPosts.append(post)
                }
            }
            if posts.count > 0{
                RealmManagerVk.updateVKCheckedPost(post: RealmManagerVk.encodeVKCheckedPostToRealm(post: source),
                                                   newLastCheckedPostId: posts[0].id,
                                                   newGroupId: source.group.id,
                                                   newGroupTitle: source.group.title,
                                                   newGroupPhotoLink: source.group.photoLink,
                                                   newGroupIsGroup: source.group.isGroup)
                source.lastCheckedPostId = posts[0].id
            }
            //print(source.group.title, posts.count)
        }
        for post in lastPosts{
            RealmManagerVk.saveNewVKPost(post: RealmManagerVk.encodeVKPostToRealm(post: post))
        }
        return lastPosts
    }
    
    static func getPosts() -> [VKPost]{
        let oldRealmPosts = RealmManagerVk.getVKPosts()
        var oldPosts = [VKPost]()
        for post in oldRealmPosts{
            oldPosts.append(RealmManagerVk.encodeRealmVkPostToJust(post: post))
        }
        oldPosts.append(contentsOf: checkNewPosts())
        oldPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return oldPosts
    }
    
    
    static func createChatByMessages() -> [MessageClass]{
        var mess = [MessageClass]()
        let posts = WorkingVk.getPosts()
        for post in posts{
            let message = MessageClass(head: post.group.title,
                                       message: post.text,
                                       time: WorkingVk.translateUnixTime(time: Int(post.date)!),
                                       url: post.url,
                                       post: post)
//            if post.hasPhoto {
//                message.message += "\nHas Photo"
//            }
//            if post.hasLink {
//                message.message += "\nHas Link"
//            }
//            if post.hasVideo {
//                message.message += "\nHas Video"
//            }
            message.message += "\n" + post.url
            mess.append(message)
        }
        return mess
    }
    
    
}
