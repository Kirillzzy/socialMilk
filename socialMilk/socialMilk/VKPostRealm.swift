//
//  VKPostRealm.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 05/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift


class VKPostRealm: Object{
    dynamic var id: String = ""
    dynamic var text: String = ""
    dynamic var date: String = ""
    dynamic var hasLink: Bool = false
    dynamic var hasVideo: Bool = false
    dynamic var url: String = ""
    dynamic var groupTitle: String = ""
    dynamic var groupId: String = ""
    dynamic var groupPhotoLink: String = ""
    dynamic var groupIsGroup: Bool = true
    
}
