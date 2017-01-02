//
//  FBCheckedPost.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation


class FBCheckedPost{
    var lastCheckedPostId = "0"
    var group = FBChooseGroupClass()
    
    init(lastCheckedPostId: String, group: FBChooseGroupClass){
        self.lastCheckedPostId = lastCheckedPostId
        self.group = group
    }
    
    init(){}
    
}

// MARK: - Hashable, Equatable
extension FBCheckedPost: Hashable, Equatable{
    static func ==(lhs: FBCheckedPost, rhs: FBCheckedPost) -> Bool {
        return lhs.group.id == rhs.group.id
    }
    
    
    var hashValue: Int{
        get{
            return "\(group.id), \(group.screenName)".hashValue
        }
    }
}
