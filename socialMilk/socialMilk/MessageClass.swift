//
//  MessangeClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class MessageClass {
    var head: String = ""
    var message: String = ""
    var time: NSDate = NSDate()
    
    init(head: String, message: String, time: NSDate){
        self.head = head
        self.message = message
        self.time = time
    }
}
