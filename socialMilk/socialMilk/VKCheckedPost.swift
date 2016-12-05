//
//  VKPost.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 04/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class VKCheckedPost{
    var lastCheckedPostId = "0"
    var group = ChooseGroupClass()
    
    init(lastCheckedPostId: String, group: ChooseGroupClass){
        self.lastCheckedPostId = lastCheckedPostId
        self.group = group
    }
}
