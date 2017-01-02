//
//  FBChooseGroupClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation

class FBChooseGroupClass{
    var title: String = ""
    var id: String = ""
    var photoLink: String = ""
    var description: String = ""
    var screenName: String = ""
    
    init(title: String, id: String, photoLink: String, description: String, screenName: String){
        self.title = title
        self.id = id
        self.photoLink = photoLink
        self.description = description
        self.screenName = screenName
    }
    
    init(){}
}
