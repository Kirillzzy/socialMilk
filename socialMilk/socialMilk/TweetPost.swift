//
//  Tweet.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation

class TweetPost{
    var user: TwitterChooseGroupClass = TwitterChooseGroupClass()
    var text: String = ""
    var date: String = ""
    var id: String = ""
    var hasLink: Bool = false
    var hasPhoto: Bool = false
    var hasVideo: Bool = false
    var url: String = ""
    var linkLink: String = ""
    var photoLink: String = ""
    var videoLink: String = ""
    
    init(user: TwitterChooseGroupClass, text: String, date: String, id: String, hasLink: Bool, hasPhoto: Bool,
         hasVideo: Bool, linkLink: String, photoLink: String, videoLink: String){
        self.user = user
        self.text = text
        self.date = date
        self.id = id
        self.hasLink = hasLink
        self.hasPhoto = hasPhoto
        self.hasVideo = hasVideo
        self.linkLink = linkLink
        self.videoLink = videoLink
        self.photoLink = photoLink
        self.url = "twitter.com/\(self.user.screenName)/status/\(self.id)"
    }
    
    init(){}
}
