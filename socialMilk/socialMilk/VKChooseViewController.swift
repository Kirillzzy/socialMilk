//
//  VKChooseViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SDWebImage

class VKChooseViewController: UIViewController, ChooseViewControllerProtocol {
    
    @IBOutlet weak var groupsTableView: UITableView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var groupsAndPeople = [VKChooseGroupClass]()
    var checked = [String: VKChooseGroupClass?]()
    var checkedItems = Set<VKCheckedPost>()

    override func loadView() {
        super.loadView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.rowHeight = CGFloat(60)
        blackView.layer.masksToBounds = true
        blackView.layer.cornerRadius = 5
        groupsTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updatePlaces()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isEnabledBackButton(how: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveCheckedItems()
    }
    
    
    func reloadTableView(){
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
            cell.setChecked(how: true)
        } else{
            cell.setChecked(how: false)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        groupsTableView.deselectRow(at: indexPath, animated: true)
        let cell = groupsTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
        if !cell.isChecked(){
            cell.setChecked(how: true)
            self.checked[String(indexPath.row)] = self.groupsAndPeople[indexPath.row]
        } else{
            cell.setChecked(how: false)
            for i in self.checkedItems{
                if i.group.id == self.checked[String(indexPath.row)]??.id{
                    self.checkedItems.remove(i)
                    break
                }
            }
            self.checked.removeValue(forKey: String(indexPath.row))
        }
        updateSelfTitle()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }

    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func updatePlaces(){
        showLoadingView()
        self.groupsAndPeople = VKManagerWorker.GroupsPeopleGet()
        let sources = WorkingVk.sources
        for source in sources{
            let newSource = VKChooseGroupClass(title: source.group.title,
                                               photoLink: source.group.photoLink,
                                               id: source.group.id,
                                               isGroup: source.group.isGroup)
            
            for i in 0..<self.groupsAndPeople.count{
                if self.groupsAndPeople[i].id == newSource.id{
                    self.checked[String(i)] = newSource
                    break
                }
            }
            self.checkedItems.insert(source)
        }
        let when = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.hideLoadingView()
            self.reloadTableView()
            self.updateSelfTitle()
            self.isEnabledBackButton(how: true)
        }
    }
    
    func saveCheckedItems(){
        for item in checked{
            if item.value != nil{
                if (checkedItems.filter({$0.group.id == item.value?.id})).count == 0{
                    checkedItems.insert(VKCheckedPost(lastCheckedPostId: "0", group: item.value!))
                }
            }
        }
        var newCheckedItems = [VKCheckedPost]()
        for i in checkedItems{
            newCheckedItems.append(i)
        }
        WorkingVk.sources = newCheckedItems
        DispatchQueue.global(qos: .background).async {
            _ = WorkingVk.checkNewPosts()
        }
        WorkingVk.updateSources()
    }
    
    func updateSelfTitle(){
        self.title = "\(NSLocalizedString("Checked", comment: "CheckedLabel")): \(checked.count)"
        if self.checked.count > 10{
            isEnabledBackButton(how: false)
        }else{
            isEnabledBackButton(how: true)
        }
    }
    
    func isEnabledBackButton(how: Bool){
        backViewButton.isEnabled = how
    }
    
    
    func showLoadingView(){
        activityIndicator.startAnimating()
        self.blackView.isHidden = false
    }
    
    func hideLoadingView(){
        self.activityView.isHidden = true
        self.blackView.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}
