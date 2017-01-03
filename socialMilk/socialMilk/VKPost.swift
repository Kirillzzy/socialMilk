//
//  VKPost.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 04/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class VKPost{
    var id: String = ""
    var text: String = ""
    var date: String = ""
    var group: VKChooseGroupClass = VKChooseGroupClass()
    var hasLink: Bool = false
    var hasVideo: Bool = false
    var hasPhoto: Bool = false
    var url: String = ""
    var linkLink: String = ""
    var photoLink: String = ""
    var videoLink: String = ""
    var hasLike: Bool = false
    var hasRepost: Bool = false
    
    
    init(id: String, text: String, date: String, group: VKChooseGroupClass, hasLink: Bool, hasVideo: Bool,
         hasPhoto: Bool, linkLink: String, photoLink: String, videoLink: String, hasLike: Bool = false, hasRepost: Bool = false){
        self.id = id
        self.text = text
        self.date = date
        self.group = group
        self.hasLink = hasLink
        self.hasVideo = hasVideo
        self.hasPhoto = hasPhoto
        self.url = ("vk.com/public" + group.id + "?w=wall-" + group.id + "_" + self.id)
        self.linkLink = linkLink
        self.photoLink = photoLink
        self.videoLink = videoLink
        self.hasLike = hasLike
        self.hasRepost = hasRepost
    }
    
    init(){}
}
