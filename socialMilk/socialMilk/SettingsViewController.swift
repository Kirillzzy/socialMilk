//
//  SettingsViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit


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


class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var settingsTableView: UITableView!
    let sectionsNames = ["General", "Accounts", "Feedback"]
    var settingsArray = [[settings]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.estimatedRowHeight = 40
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
        return settingsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsChooseTableViewCell
        cell.imageImageView.image = settingsArray[indexPath.section][indexPath.row].image
        cell.settingsTextLabel.text = settingsArray[indexPath.section][indexPath.row].text
        if !settingsArray[indexPath.section][indexPath.row].hasImage{
            cell.imageWidthConstraint.constant = 0
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1{
            performSegue(withIdentifier: settingsArray[indexPath.section][indexPath.row].nameOfSegue, sender: true)
        }
    }
    
    
    func addFirstProperties(){
        for _ in 0..<3{
            settingsArray.append([settings]())
        }
        settingsArray[0].append(settings(image: nil, text: "Internet", nameOfSegue: "gotoInternetSettings"))
        settingsArray[0].append(settings(image: nil, text: "Background Image", nameOfSegue: "gotoBackgroundImageSettings"))
        if UserDefaults.standard.bool(forKey: AppsStaticClass.keyVK){
            settingsArray[1].append(settings(image: #imageLiteral(resourceName: "vkLogoBlackBig"),
                                          text: VKManagerWorker.userName,
                                          nameOfSegue: "gotoChooseVK"))
        }
        if UserDefaults.standard.bool(forKey: AppsStaticClass.keyTwitter){
            settingsArray[1].append(settings(image: #imageLiteral(resourceName: "twitterLogo"),
                                          text: "@\(TwitterManager.userName)",
            nameOfSegue: "gotoChooseTwitter"))
        }
        settingsArray[2].append(settings(image: nil, text: "Rate Us", nameOfSegue: "gotoRateUs"))
        settingsArray[2].append(settings(image: nil, text: "Contact Developer", nameOfSegue: "gotoContactDev"))
        settingsArray[2].append(settings(image: nil, text: "About Social Milk", nameOfSegue: "gotoProductInfo"))
    }

}

