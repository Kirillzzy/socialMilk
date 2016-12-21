//
//  TwitterChooseGroupClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class TwitterChooseGroupClass{
    var title: String = ""
    var photoLink: String = ""
    var id: String = ""
    var description: String = ""
    
    init(title: String, photoLink: String, id: String, description: String){
        self.title = title
        self.photoLink = photoLink
        self.id = id
        self.description = description
    }
    
    init(){}
}
