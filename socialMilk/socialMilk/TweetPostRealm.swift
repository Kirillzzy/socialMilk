//
//  TweetPostRealm.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

class TweetPostRealm: Object{
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
    dynamic var userTitle: String = ""
    dynamic var userPhotoLink: String = ""
    dynamic var userId: String = ""
    dynamic var userDescription: String = ""
    dynamic var userScreenName: String = ""
    dynamic var hasLike: Bool = false
    dynamic var hasRepost: Bool = false
}
