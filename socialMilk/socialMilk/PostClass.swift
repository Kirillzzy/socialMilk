//
//  PostClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/02/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation


class PostClass{
    var id: String = ""
    var text: String = ""
    var date: String = ""
    var user: UserClass = UserClass()
    var url: String = ""
    var link: String = ""
    var photo: String = ""
    var video: String = ""
    var source: String = "" // <-temp
    
    init(id: String, text: String, date: String, user: UserClass, link: String, photo: String, video: String, source: String){
        self.id = id
        self.text = text
        self.date = date
        self.user = user
        self.url = ""// = ("vk.com/public" + group.id + "?w=wall-" + group.id + "_" + self.id)
        self.link = link
        self.photo = photo
        self.video = video
        self.source = source
    }
    
    init(){}

}
