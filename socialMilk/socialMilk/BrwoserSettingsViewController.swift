//
//  BrwoserSettingsViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 17/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit


class BrwoserSettingsViewController: UIViewController, SettingsProtocol {
    @IBOutlet weak var settingsTableView: UITableView!
    var settingsArray = [browserSettings]()
    let sectionsNames = ["Open links in"]
    var browserType: WorkingDefaults.Browser = WorkingDefaults.Browser.my
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.rowHeight = 70
        addFirstProperties()
        self.settingsTableView.register(UINib(nibName: "SettingsBoolTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        browserType = WorkingDefaults.getBrowser()
        reloadUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for i in 0 ..< settingsArray.count{
            if (settingsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! SettingsBoolTableViewCell).isChecked(){
                WorkingDefaults.setBrowser(how: settingsArray[i].browserType)
            }
        }
    }
    
    func reloadUI(){
        addFirstProperties()
        settingsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = settingsTableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsBoolTableViewCell
        cell.titleLabel.text = settingsArray[indexPath.row].text
        if browserType == settingsArray[indexPath.row].browserType{
            cell.setChecked(how: true)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        settingsTableView.deselectRow(at: indexPath, animated: true)
        for i in 0 ..< settingsArray.count{
            (settingsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as! SettingsBoolTableViewCell).setChecked(how: false)
        }
        (settingsTableView.cellForRow(at: indexPath) as! SettingsBoolTableViewCell).setChecked(how: true)
    }
    
    
    func addFirstProperties(){
        settingsArray.removeAll()
        settingsArray.append(browserSettings(text: "Social Milk Browser"))
        settingsArray.append(browserSettings(text: "Safari", browserType: WorkingDefaults.Browser.safari))
    }
}


