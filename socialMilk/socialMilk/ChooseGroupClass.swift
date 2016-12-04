//
//  ChooseGroupClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 04/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class ChooseGroupClass{
    var title: String = ""
    var id: String = ""
    var photoLink: String = ""
    var isGroup: Bool = true
    
    init(title: String, photoLink: String, id: String, isGroup: Bool){
        self.title = title
        self.photoLink = photoLink
        self.id = id
        self.isGroup = isGroup
    }
    
    init(){}
    
}
