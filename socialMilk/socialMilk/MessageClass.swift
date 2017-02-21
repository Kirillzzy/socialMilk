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
    var timeNSDate: NSDate!
    var url: String = ""
    var post = PostClass()
    var typeOfMessage: type
    var colorBubble: UIImage = UIImage()
    
    enum type{
        case twitter
        case vk
        case fb
    }
    
    init(head: String, message: String, timeNSDate: NSDate, url: String, post: PostClass){
        self.head = head
        self.message = message
        self.timeNSDate = timeNSDate
        self.url = url
        self.post = post
        self.typeOfMessage = type.vk
        self.colorBubble = #imageLiteral(resourceName: "vkCircle")
    }
}
