//
//  FBPostRealm.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

class FBPostRealm: Object{
    dynamic var text: String = ""
    dynamic var date: String = ""
    dynamic var id: String = ""
    dynamic var hasLink: Bool = false
    dynamic var hasPhoto: Bool = false
    dynamic var hasVideo: Bool = false
    dynamic var linkLink: String = ""
    dynamic var photoLink: String = ""
    dynamic var videoLink: String = ""
    dynamic var url: String = ""
    dynamic var groupTitle: String = ""
    dynamic var groupPhotoLink: String = ""
    dynamic var groupId: String = ""
    dynamic var groupDescription: String = ""
    dynamic var groupScreenName: String = ""
}
