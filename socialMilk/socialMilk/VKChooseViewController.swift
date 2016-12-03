//
//  VKChooseViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SDWebImage

class VKChooseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupsTableView: UITableView!
    
    var groups = [ChooseGroupClass]()
    private let vk: VKManager = VKManager()
    
    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.rowHeight = CGFloat(60)
        let when = DispatchTime.now() + 10
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.reloadTableView()
        }
    }
    
    
    func reloadTableView(){
        groups = vk.groupsAndPeople
        print(groups.count)
        self.groupsTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        self.reloadUI()
    }
    
    func reloadUI(){
        self.groupsTableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return groups.count
        return 1
    }
    //load new messages
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupsTableViewCell
        cell.mainImageVIew.sd_setImage(with: URL(string: groups[indexPath.row].photoLink))
        cell.titleLabel.text = groups[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupsTableView.deselectRow(at: indexPath, animated: true)
        /*let cell = groupsTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
        if cell.checkButton.imageView?.image != #imageLiteral(resourceName: "checkBoxSet"){
            cell.checkButton.imageView?.image = #imageLiteral(resourceName: "checkBoxSet")
        } else{
            cell.checkButton.imageView?.image = nil
        }*/
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }


}
