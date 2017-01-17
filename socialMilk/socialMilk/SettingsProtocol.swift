//
//  settingsProtocol.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 17/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import Foundation



struct settings{
    var image: UIImage?
    var text: String
    var nameOfSegue: String
    var hasImage: Bool
    
    init(image: UIImage?, text: String, nameOfSegue: String){
        self.image = image
        self.text = text
        self.nameOfSegue = nameOfSegue
        if image == nil{
            self.hasImage = false
        }else{
            self.hasImage = true
        }
    }
    
}


struct browserSettings{
    var isChecked: Bool = false
    var text: String = ""
    var browserType: WorkingDefaults.Browser = WorkingDefaults.Browser.my
    
    init(text: String, isChecked: Bool = false,
         browserType: WorkingDefaults.Browser = WorkingDefaults.Browser.my){
        self.text = text
        self.isChecked = isChecked
        self.browserType = browserType
    }
}


protocol SettingsProtocol: UITableViewDelegate, UITableViewDataSource{
    weak var settingsTableView: UITableView! {get set}
    
    func addFirstProperties()
    func reloadUI()
}
