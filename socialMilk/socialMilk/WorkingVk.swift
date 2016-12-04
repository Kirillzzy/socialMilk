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
    static let vk = VKManager.sharedInstance
    static var lastPosts: [VKPost] = [VKPost]()
    
    
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
    
    static func checkNewPosts(){
        lastPosts.removeAll()
        for source in sources{
            var posts = [VKPost]()
            posts = vk.WallGet(group: source.group)
            if false/*source.lastCheckedPostId == "0"*/{ // temporary for testing
                //source.lastCheckedPostId = posts[0].id
            }else{
                for post in posts{
                    /// adding last post in notification
                    if post.id == source.lastCheckedPostId{
                        break
                    }
                    source.lastCheckedPostId = post.id
                    lastPosts.append(post)
                }
            }
            //print(source.group.title, ": ", posts.count)
        }
    }
    
    static func getNewPosts() -> [VKPost]{
        checkNewPosts()
        return lastPosts
    }
    
    
    static func createChatByMessages() -> [MessageClass]{
        var mess = [MessageClass]()
        let posts = WorkingVk.getNewPosts()
        for post in posts{
            let message = MessageClass(head: post.group.title, message: post.text, time: WorkingVk.translateUnixTime(time: Int(post.date)!))
            mess.append(message)
        }
        return mess
    }
    
    //keychain
}
