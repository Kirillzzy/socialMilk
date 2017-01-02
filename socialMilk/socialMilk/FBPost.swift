//
//  FBPost.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation


class FBPost{
    var group: FBChooseGroupClass = FBChooseGroupClass()
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
    
    init(group: FBChooseGroupClass, text: String, date: String, id: String, hasLink: Bool, hasPhoto: Bool,
         hasVideo: Bool, linkLink: String, photoLink: String, videoLink: String){
        self.group = group
        self.text = text
        self.date = date
        self.id = id
        self.hasLink = hasLink
        self.hasPhoto = hasPhoto
        self.hasVideo = hasVideo
        self.linkLink = linkLink
        self.videoLink = videoLink
        self.photoLink = photoLink
        // make url for post facebook !!!
    }
    
    init(){}
}
