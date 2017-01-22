//
//  SettingsViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController, SettingsProtocol{

    @IBOutlet weak var settingsTableView: UITableView!
    private let sectionsNames = ["General", "Accounts", "Feedback"]
    var settingsArray = [[settings]()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingsTableView.estimatedRowHeight = 40
        addFirstProperties()
        self.settingsTableView.register(UINib(nibName: "SettingsChooseTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadUI()
    }
    
    func reloadUI(){
        addFirstProperties()
        settingsTableView.reloadData()
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
        if (indexPath.section == 0 && indexPath.row == 0) || indexPath.section == 1{
            performSegue(withIdentifier: settingsArray[indexPath.section][indexPath.row].nameOfSegue, sender: true)
        }
    }
    
    
    func addFirstProperties(){
        settingsArray.removeAll()
        for _ in 0..<3{
            settingsArray.append([settings]())
        }
        settingsArray[0].append(settings(image: nil, text: "Browser", nameOfSegue: "gotoBrowserSettings"))
        settingsArray[0].append(settings(image: nil, text: "Background Image", nameOfSegue: "gotoBackgroundImageSettings"))
        settingsArray[0].append(settings(image: nil, text: "Timeline Colors", nameOfSegue: "gotoTimelineColors"))
        if WorkingDefaults.isHaveVk(){
            settingsArray[1].append(settings(image: #imageLiteral(resourceName: "vkLogoBlackBig"),
                                          text: VKManagerWorker.userName,
                                          nameOfSegue: "gotoChooseVK"))
        }
        if WorkingDefaults.isHaveTwitter(){
            settingsArray[1].append(settings(image: #imageLiteral(resourceName: "twitterLogo"),
                                          text: "@\(TwitterManager.userName)",
            nameOfSegue: "gotoChooseTwitter"))
        }
        settingsArray[2].append(settings(image: nil, text: "Rate this app", nameOfSegue: "gotoRateUs"))
        settingsArray[2].append(settings(image: nil, text: "Contact Developer", nameOfSegue: "gotoContactDev"))
        settingsArray[2].append(settings(image: nil, text: "About Social Milk", nameOfSegue: "gotoProductInfo"))
    }

}



