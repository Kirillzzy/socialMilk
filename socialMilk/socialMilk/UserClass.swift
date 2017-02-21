//
//  UserClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/02/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

class UserClass{
    var title: String = ""
    var id: String = ""
    var photoLink: String = ""
    var screenName: String = ""
    
    init(title: String, photoLink: String, id: String, screenName: String){
        self.title = title
        self.photoLink = photoLink
        self.id = id
        self.screenName = screenName
    }
    
    init(){}
}
