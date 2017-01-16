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
    var typeOfMessage: type
    
    enum type{
        case twitter
        case vk
    }
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, post: VKPost){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.post = post
        typeOfMessage = type.vk
    }
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, tweet: TweetPost){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.tweet = tweet
        typeOfMessage = type.twitter
    }
}
