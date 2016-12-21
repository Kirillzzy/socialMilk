//
//  TwitterChooseViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class TwitterChooseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var peopleTableView: UITableView!
    
    var people = [TwitterChooseGroupClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.rowHeight = CGFloat(60)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        TwitterManager.loadFollowing(callback: { people in
            if let peo = people{
                self.people = peo
            }
            self.reloadTableView()
        })
    }
    
    func reloadTableView(){
        self.peopleTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
        self.reloadUI()
    }
    
    func reloadUI(){
        self.peopleTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = peopleTableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupsTableViewCell
        print(people[indexPath.row].photoLink)
        cell.mainImageVIew.sd_setImage(with: URL(string: people[indexPath.row].photoLink))
        cell.titleLabel.text = people[indexPath.row].title
//        if checked[String(indexPath.row)] != nil{
//            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
//        } else{
//            cell.checkButton.setImage(nil, for: .normal)
//        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        peopleTableView.deselectRow(at: indexPath, animated: true)
        
//        let cell = groupsTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
//        if cell.checkButton.currentImage != #imageLiteral(resourceName: "checkBoxSet"){
//            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
//            self.checked[String(indexPath.row)] = self.groupsAndPeople[indexPath.row]
//        } else{
//            cell.checkButton.setImage(nil, for: .normal)
//            for i in 0..<self.checkedItems.count{
//                if self.checkedItems[i].group.id == self.checked[String(indexPath.row)]??.id{
//                    self.checkedItems.remove(at: i)
//                    break
//                }
//            }
//            self.checked.removeValue(forKey: String(indexPath.row))
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }


}
