//
//  Init.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 05/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation

final class Init{
    static func Init(){
        RealmManagerVk.printRealmPath()
        WorkingVk.sources = RealmManagerVk.getVKCheckedPosts()
    }
}
