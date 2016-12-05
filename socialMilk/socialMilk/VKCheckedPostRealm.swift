//
//  VKCheckedPostRealm.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 05/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift


class VKCheckedPostRealm: Object{
    dynamic var lastCheckedPostId = ""
    dynamic var groupTitle: String = ""
    dynamic var groupId: String = ""
    dynamic var groupPhotoLink: String = ""
    dynamic var groupIsGroup: Bool = true
}
