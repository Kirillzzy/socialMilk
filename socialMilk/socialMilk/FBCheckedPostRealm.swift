//
//  FBCheckedPostRealm.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

class FBCheckedPostRealm: Object{
    dynamic var lastCheckedPostId: String = ""
    dynamic var groupTitle: String = ""
    dynamic var groupPhotoLink: String = ""
    dynamic var groupId: String = ""
    dynamic var groupDescription: String = ""
    dynamic var groupScreenName: String = ""
}
