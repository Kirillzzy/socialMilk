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
    var group = VKChooseGroupClass()
    
    init(lastCheckedPostId: String, group: VKChooseGroupClass){
        self.lastCheckedPostId = lastCheckedPostId
        self.group = group
    }
    
    init(){}
}

extension VKCheckedPost: Hashable, Equatable{
    static func ==(lhs: VKCheckedPost, rhs: VKCheckedPost) -> Bool {
        return lhs.group.id == rhs.group.id
    }
    
    
    var hashValue: Int{
        get{
            return "\(group.id), \(group.title)".hashValue
        }
    }
}
