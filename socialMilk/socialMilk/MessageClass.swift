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
    var timeString: String = ""
    var timeNSDate: NSDate!
    var url: String = ""
    var post = VKPost()
    var tweet = TweetPost()
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, post: VKPost){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.post = post
    }
    
    init(head: String, message: String, timeString: String, url: String, tweet: TweetPost){
        self.head = head
        self.message = message
        self.timeString = timeString
        self.url = url
        self.tweet = tweet
    }
}
