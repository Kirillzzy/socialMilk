//
//  AddAppsViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 15/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class AddAppsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var appsTableView: UITableView!
    var availableApps = AppsStaticClass.allAvailableApps
    var soonApps = AppsStaticClass.soonApps
    let sectionsNames: [String] = ["Now available", "Soon"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.appsTableView.estimatedRowHeight = 40
        self.appsTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "AppCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return availableApps.count
        }
        return soonApps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = appsTableView.dequeueReusableCell(withIdentifier: "AppCell", for: indexPath) as! GroupsTableViewCell
        if indexPath.section == 0{
            cell.mainImageVIew.image = availableApps[indexPath.row].AppIcon
            cell.titleLabel.text = availableApps[indexPath.row].AppName
            let keyName = "have\(availableApps[indexPath.row].AppName!)"
            if UserDefaults.standard.bool(forKey: keyName){
                cell.setChecked(how: true)
            }
        }else if indexPath.section == 1{
            cell.mainImageVIew.image = soonApps[indexPath.row].0
            cell.titleLabel.text = soonApps[indexPath.row].1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        appsTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            if indexPath.row == 0{
                AppsStaticClass.saveVK(how: true)
                (appsTableView.cellForRow(at: indexPath)as! GroupsTableViewCell).setChecked(how: true)
                performSegue(withIdentifier: "fromAddToVKChooseSegue", sender: self)
            }else if indexPath.row == 1{
                AppsStaticClass.saveTwitter(how: true)
                performSegue(withIdentifier: "fromAddtoTwitterChooseSegue", sender: self)
            }
        }
    }

    
}

//// MARK: - segue
//extension AddAppsViewController{
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "fromAddToVKChooseSegue"{
//            let vc = segue.destination as! VKChooseViewController
//        }else if segue.identifier == "fromAddtoTwitterChooseSegue"{
//            let vc = segue.destination as! TwitterChooseViewController
//        }
//    }
//}
