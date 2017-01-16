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
        var day = String(calendar.component(.day, from: date as Date))
        var month = String(calendar.component(.month, from: date as Date))
        
        let todayDate = Date()
        let todayDay = String(calendar.component(.day, from: todayDate as Date))
        let todayMonth = String(calendar.component(.month, from: date as Date))
        
        if hour.characters.count == 1{
            hour = "0" + hour
        }
        if minutes.characters.count == 1{
            minutes = "0" + minutes
        }
        
        if todayDay == day && todayMonth == month{
            return "Today \(hour):\(minutes)"
        }
        
        if String(Int(todayDay)! - 1) == day && todayMonth == month{
            return "Yesterday \(hour):\(minutes)"
        }
        
        if day.characters.count == 1{
            day = "0" + day
        }
        if month.characters.count == 1{
            month = "0" + month
        }
        return "\(day).\(month) \(hour):\(minutes)"
    }
    
    static func checkNewPosts() -> [VKPost]{
        var lastPosts: [VKPost] = [VKPost]()
        var count = 0
        for source in sources{
            VKManagerWorker.WallGet(group: source.group, callback: { posts in
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
                        RealmManagerVk.updateVKCheckedPost(post: RealmManagerVk.encodeVKCheckedPostToRealm(post: source),
                                                           newLastCheckedPostId: pos[0].id,
                                                           newGroupId: source.group.id,
                                                           newGroupTitle: source.group.title,
                                                           newGroupPhotoLink: source.group.photoLink,
                                                           newGroupIsGroup: source.group.isGroup)
                        source.lastCheckedPostId = pos[0].id
                    }
                }
                count += 1
            })
        }
        while(count != sources.count){}
        for post in lastPosts{
            RealmManagerVk.saveNewVKPost(post: RealmManagerVk.encodeVKPostToRealm(post: post))
        }
        lastPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return lastPosts
    }
    
    
    static func getOldPosts() -> [VKPost]{
        let oldRealmPosts = RealmManagerVk.getVKPosts()
        var oldPosts = [VKPost]()
        for post in oldRealmPosts{
            oldPosts.append(RealmManagerVk.encodeRealmVkPostToJust(post: post))
        }
        oldPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return oldPosts
    }
    
    static func getPosts() -> [VKPost]{
        var oldPosts = getOldPosts()
        oldPosts.append(contentsOf: checkNewPosts())
        oldPosts.sort(by: {post1, post2 in Int(post1.date)! < Int(post2.date)!})
        return oldPosts
    }
    
    static func encodePostsToMessages(posts: [VKPost]) -> [MessageClass]{
        var mess = [MessageClass]()
        for post in posts{
            let message = MessageClass(head: post.group.title,
                                       message: post.text,
                                       timeNSDate: WorkingVk.translateUnixTime(time: Int(post.date)!),
                                       url: post.url,
                                       post: post)
            
            mess.append(message)
        }
        return mess
    }
    
    
    static func createChatByMessages() -> [MessageClass]{
        return encodePostsToMessages(posts: getPosts())
    }
    
    
}
