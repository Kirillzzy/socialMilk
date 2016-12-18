//
//  Init.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 05/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import SwiftyVK
import Accounts
import Social

final class Init{
    static func Init(){
        RealmManagerVk.printRealmPath()
        WorkingVk.sources = RealmManagerVk.getVKCheckedPosts()
    }
}
