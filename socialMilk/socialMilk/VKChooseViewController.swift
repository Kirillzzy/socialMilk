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
    var status: Bool = false{
        didSet{
            //reloadTableView()
        }
    }


    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.rowHeight = CGFloat(60)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadTableView()
        print(status)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        var checkedItems = [ChooseGroupClass]()
        for i in 0..<groupsTableView.numberOfRows(inSection: 0){
            let cell = groupsTableView.cellForRow(at: IndexPath(row: i, section: 0)) as? GroupsTableViewCell
            if cell == nil{
                continue
            }
            if cell?.checkButton.currentImage == #imageLiteral(resourceName: "checkBoxSet"){
                checkedItems.append(vk.groupsAndPeople[i])
            }
        }
        WorkingVk.sources = checkedItems
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
        return vk.groupsAndPeople.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupsTableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupsTableViewCell
        cell.mainImageVIew.sd_setImage(with: URL(string: vk.groupsAndPeople[indexPath.row].photoLink))
        cell.titleLabel.text = vk.groupsAndPeople[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupsTableView.deselectRow(at: indexPath, animated: true)
        let cell = groupsTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
        if cell.checkButton.currentImage != #imageLiteral(resourceName: "checkBoxSet"){
            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
        } else{
            cell.checkButton.setImage(nil, for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }


}
