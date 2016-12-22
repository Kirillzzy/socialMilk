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
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var people = [TwitterChooseGroupClass]()
    var checked = [String: TwitterChooseGroupClass?]()
    var checkedItems = [TweetCheckedPost]()

    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTableView.rowHeight = CGFloat(60)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let sources = WorkingTwitter.sources
        activityIndicator.startAnimating()
        TwitterManager.loadFollowing(callback: { people in
            if let peo = people{
                self.people = peo
                for source in sources{
                    let newSource = TwitterChooseGroupClass(title: source.user.title,
                                                            photoLink: source.user.photoLink,
                                                            id: source.user.id,
                                                            description: source.user.description,
                                                            screenName: source.user.screenName)
                    
                    for i in 0..<self.people.count{
                        if self.people[i].id == newSource.id{
                            self.checked[String(i)] = newSource
                            break
                        }
                    }
                    self.checkedItems.append(source)
                }
            }
            
            self.activityIndicator.hidesWhenStopped = true
            self.activityView.isHidden = true
            self.activityIndicator.stopAnimating()
            self.reloadTableView()
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for item in checked{
            if item.value != nil{
                if (checkedItems.filter({$0.user.id == item.value?.id})).count == 0{
                    checkedItems.append(TweetCheckedPost(lastCheckedTweetId: "0", user: item.value!))
                }
            }
        }
        WorkingTwitter.sources = checkedItems
        DispatchQueue.global(qos: .background).async {
            _ = WorkingTwitter.checkNewTweets()
        }
        WorkingTwitter.updateSources()
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
        cell.mainImageVIew.sd_setImage(with: URL(string: people[indexPath.row].photoLink))
        cell.titleLabel.text = people[indexPath.row].title
        if checked[String(indexPath.row)] != nil{
            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
        } else{
            cell.checkButton.setImage(nil, for: .normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        peopleTableView.deselectRow(at: indexPath, animated: true)
        let cell = self.peopleTableView.cellForRow(at: indexPath) as! GroupsTableViewCell
        if cell.checkButton.currentImage != #imageLiteral(resourceName: "checkBoxSet"){
            cell.checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
            self.checked[String(indexPath.row)] = self.people[indexPath.row]
        } else{
            cell.checkButton.setImage(nil, for: .normal)
            for i in 0..<self.checkedItems.count{
                if self.checkedItems[i].user.id == self.checked[String(indexPath.row)]??.id{
                    self.checkedItems.remove(at: i)
                    break
                }
            }
            self.checked.removeValue(forKey: String(indexPath.row))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 70
    }


}
