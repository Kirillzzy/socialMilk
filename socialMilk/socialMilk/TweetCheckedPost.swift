//
//  TweetCheckedPost.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation

class TweetCheckedPost{
    var lastCheckedTweetId = "0"
    var user = TwitterChooseGroupClass()
    
    init(lastCheckedTweetId: String, user: TwitterChooseGroupClass){
        self.lastCheckedTweetId = lastCheckedTweetId
        self.user = user
    }
    
    init(){}

}
