//
//  ChatClass.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation


class ChatClass {
    var messages = [MessageClass]()
    var chatTitle: String = ""
    
    init(chatTitle: String, messages: [MessageClass]){
        self.chatTitle = chatTitle
        self.messages = messages
    }
    
    init(){}
}
