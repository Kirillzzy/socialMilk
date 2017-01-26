//
//  MessangeClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class MessageClass {
    var head: String = ""
    var message: String = ""
    var timeNSDate: NSDate!
    var url: String = ""
    var post = VKPost()
    var tweet = TweetPost()
    var postFb = FBPost()
    var typeOfMessage: type
    var colorBubble: UIImage = UIImage()
    
    enum type{
        case twitter
        case vk
        case fb
    }
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, post: VKPost){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.post = post
        self.typeOfMessage = type.vk
        self.colorBubble = #imageLiteral(resourceName: "vkCircle")
    }
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, postFb: FBPost){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.postFb = postFb
        self.typeOfMessage = type.fb
        self.colorBubble = #imageLiteral(resourceName: "circle")
    }
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, tweet: TweetPost){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.tweet = tweet
        self.typeOfMessage = type.twitter
        self.colorBubble = #imageLiteral(resourceName: "twitterCircle")
    }
}
