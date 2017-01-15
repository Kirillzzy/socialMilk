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
    let sectionsNames = ["General", "Accounts", "Developer"]
    var settingsArray = [settings]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.estimatedRowHeight = 50
        addFirstProperties()
        self.settingsTableView.register(UINib(nibName: "SettingsChooseTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionsNames.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return settingsArray.count
        }else{
            return 0 // <- temporary
        }
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
                                          text: VKManagerWorker.userName,
                                          nameOfSegue: "gotoChooseVK"))
        }
        if UserDefaults.standard.bool(forKey: AppsStaticClass.keyTwitter){
            settingsArray.append(settings(image: #imageLiteral(resourceName: "twitterLogo"),
                                          text: "@\(TwitterManager.userName)",
                                          nameOfSegue: "gotoChooseTwitter"))
        }
    }

}

