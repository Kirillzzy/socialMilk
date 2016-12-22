//
//  ChatClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import UIKit

class ChatClass {
    
    var messages = [MessageClass]()
    var chatTitle: String = ""
    var chatImage: UIImage!
    var chatTime: String = ""
    var chatDescription: String = ""
    
    init(chatTitle: String, chatImage: UIImage, chatTime: String, chatDescription: String){
        self.chatTitle = chatTitle
        self.chatImage = chatImage
        self.chatTime = chatTime
        self.chatDescription = chatDescription
    }
    
    init(){}
        
}
