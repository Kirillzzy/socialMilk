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
    var group: ChooseGroupClass = ChooseGroupClass()
    var hasLink: Bool = false
    var hasVideo: Bool = false
    var hasPhoto: Bool = false
    
    var url: String = "" // make url
    
    init(id: String, text: String, date: String, group: ChooseGroupClass, hasLink: Bool, hasVideo: Bool, hasPhoto: Bool){
        self.id = id
        self.text = text
        self.date = date
        self.group = group
        self.hasLink = hasLink
        self.hasVideo = hasVideo
        self.hasPhoto = hasPhoto
    }
    
    init(){}
}
