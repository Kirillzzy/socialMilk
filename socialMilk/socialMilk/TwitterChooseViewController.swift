//
//  TwitterChooseViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 21/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class TwitterChooseViewController: UIViewController, ChooseViewControllerProtocol {
    
    @IBOutlet weak var peopleTableView: UITableView!
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var people = [TwitterChooseGroupClass]()
    var checked = [String: TwitterChooseGroupClass?]()
    var checkedItems = Set<TweetCheckedPost>()
    let defaultCursor = "-1"
    var lastCursor: String = ""
    
    var numOfChecked: Int = 0{
        didSet{
            updateSelfTitle()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.rowHeight = CGFloat(60)
        blackView.layer.masksToBounds = true
        blackView.layer.cornerRadius = 5
        peopleTableView.register(UINib(nibName: "GroupsTableViewCell", bundle: nil), forCellReuseIdentifier: "GroupCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        lastCursor = defaultCursor
        updatePlaces()
        numOfChecked = WorkingTwitter.sources.count
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
        cell.mainImageVIew.sd_setImage(with: URL(string: people[indexPath.row].photoLink))
        cell.titleLabel.text = people[indexPath.row].title
        if checked[String(indexPath.row)] != nil{
            cell.setChecked(how: true)
        } else{
            cell.setChecked(how: false)
        }
        
        if indexPath.row == people.count - 1 && lastCursor != "-1"{
            updatePlaces()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        peopleTableView.deselectRow(at: indexPath, animated: true)
        let cell = self.peopleTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
        if !cell.isChecked(){
            cell.setChecked(how: true)
            self.checked[String(indexPath.row)] = self.people[indexPath.row]
            numOfChecked += 1
        } else{
            cell.setChecked(how: false)
            for i in self.checkedItems{
                if i.user.id == self.checked[String(indexPath.row)]??.id{
                    self.checkedItems.remove(i)
                    break
                }
            }
            self.checked.removeValue(forKey: String(indexPath.row))
            numOfChecked -= 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }

    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    func saveCheckedItems(){
        for item in checked{
            if item.value != nil{
                if (checkedItems.filter({$0.user.id == item.value?.id})).count == 0{
                    checkedItems.insert(TweetCheckedPost(lastCheckedTweetId: "0", user: item.value!))
                }
            }
        }
        var newCheckedItems = [TweetCheckedPost]()
        for i in checkedItems{
            newCheckedItems.append(i)
        }
        WorkingTwitter.sources = newCheckedItems
        DispatchQueue.global(qos: .background).async {
            _ = WorkingTwitter.checkNewTweets()
        }
        WorkingTwitter.updateSources()
    }
    
    func updatePlaces(){
        let sources = WorkingTwitter.sources
        showLoadingView()
        TwitterManager.loadLastFollowing(cursor: lastCursor, callback: { people, cursor in
            if let peo = people{
                self.lastCursor = cursor!
                for source in sources{
                    let newSource = TwitterChooseGroupClass(title: source.user.title,
                                                            photoLink: source.user.photoLink,
                                                            id: source.user.id,
                                                            description: source.user.description,
                                                            screenName: source.user.screenName)
                    
                    for i in 0..<peo.count{
                        if peo[i].id == newSource.id{
                            self.checked[String(self.people.count + i)] = newSource
                            break
                        }
                    }
                    self.checkedItems.insert(source)
                    //self.checkedItems.append(source)
                }
                self.people.append(contentsOf: peo)
                if peo.count < 200{
                    self.lastCursor = "-1"
                }
            }
            self.hideLoadingView()
            self.reloadTableView()
            self.updateSelfTitle()
            self.isEnabledBackButton(how: true)
        })
    }
    
    func updateSelfTitle(){
        self.title = "Checked: \(numOfChecked)"
        if numOfChecked > 10{
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
