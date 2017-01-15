//
//  SettingsViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit


struct settings{
    var image: UIImage
    var text: String
    var nameOfSegue: String
    
    init(image: UIImage, text: String, nameOfSegue: String){
        self.image = image
        self.text = text
        self.nameOfSegue = nameOfSegue
    }
}


class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var settingsTableView: UITableView!
    var settingsArray = [settings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.estimatedRowHeight = 50
        addFirstProperties()
        self.settingsTableView.register(UINib(nibName: "SettingsChooseTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsChooseTableViewCell
        cell.imageImageView.image = settingsArray[indexPath.row].image
        cell.settingsTextLabel.text = settingsArray[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: settingsArray[indexPath.row].nameOfSegue, sender: true)
    }
    
    
    func addFirstProperties(){
        if UserDefaults.standard.bool(forKey: AppsStaticClass.keyVK){
            settingsArray.append(settings(image: #imageLiteral(resourceName: "vkLogoBlackBig"),
                                          text: "Choose groups from VK",
                                          nameOfSegue: "gotoChooseVK"))
        }
        if UserDefaults.standard.bool(forKey: AppsStaticClass.keyTwitter){
            settingsArray.append(settings(image: #imageLiteral(resourceName: "twitterLogo"),
                                          text: "Choose people from Twitter",
                                          nameOfSegue: "gotoChooseTwitter"))
        }
    }

}

