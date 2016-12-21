//
//  TweetCheckedPostRealm.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import RealmSwift

class TweetCheckedPostRealm: Object{
    dynamic var lastCheckedTweetId: String = ""
    dynamic var userTitle: String = ""
    dynamic var userPhotoLink: String = ""
    dynamic var userId: String = ""
    dynamic var userDescription: String = ""
    dynamic var userScreenName: String = ""
}
