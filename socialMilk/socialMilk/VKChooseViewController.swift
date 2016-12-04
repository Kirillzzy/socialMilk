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
    
    private let vk: VKManager = VKManager.sharedInstance
    var groupsAndPeople = [ChooseGroupClass]()
    var checked = [String: ChooseGroupClass?]()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.rowHeight = CGFloat(60)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        groupsAndPeople = vk.GroupsPeopleGet()
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.reloadTableView()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        var checkedItems = [VKCheckedPost]()
        for item in checked{
            if item.value != nil{
                checkedItems.append(VKCheckedPost(lastCheckedPostId: "0", group: item.value!))
            }
        }
        WorkingVk.sources = checkedItems
        //WorkingVk.checkNewPosts()
    }
    
    static let sharedInstance: VKChooseViewController = {
        let instance = VKChooseViewController()
        return instance
    }()
    
    func reloadTableView(){
        self.groupsTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        self.reloadUI()
    }
    
    func reloadUI(){
        self.groupsTableView.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsAndPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupsTableViewCell
        cell.mainImageVIew.sd_setImage(with: URL(string: groupsAndPeople[indexPath.row].photoLink))
        cell.titleLabel.text = groupsAndPeople[indexPath.row].title
        if checked[String(indexPath.row)] != nil{
            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
        } else{
            cell.checkButton.setImage(nil, for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupsTableView.deselectRow(at: indexPath, animated: true)
        let cell = groupsTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
        if cell.checkButton.currentImage != #imageLiteral(resourceName: "checkBoxSet"){
            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
            self.checked[String(indexPath.row)] = self.groupsAndPeople[indexPath.row]
        } else{
            cell.checkButton.setImage(nil, for: .normal)
            self.checked[String(indexPath.row)] = nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }


}
