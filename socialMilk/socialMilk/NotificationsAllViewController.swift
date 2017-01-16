//
//  NotificationsAllViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 16/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class NotificationsAllViewController: UIViewController, NotificationsViewControllerProtocol {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    
    var apps = AppsStaticClass.apps
    var chat = [ChatClass]()
    var sectionsNames = ["Old Posts", "New Posts"]
    var lastPerform: Constants.fromSegueShowView = Constants.fromSegueShowView.null
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesTableView.estimatedRowHeight = 90
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        chat.append(ChatClass())
        chat.append(ChatClass())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isEnabledBackButton(how: false)
        self.activityView.isHidden = false
        loadNews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func refreshTableView(sender: AnyObject){
        loadNews()
    }
    
    
    func reloadTableView(){
        self.reloadUI()
        let numberOfRowsOld = chat[0].messages.count
        let numberOfRowsNew = chat[1].messages.count
        if numberOfRowsNew > 0 {
            let indexPath = IndexPath(row: 0, section: 1)
            scrollTopTableView(for: indexPath)
        }else if numberOfRowsOld > 0{
            let indexPath = IndexPath(row: numberOfRowsOld - 1, section: 0)
            scrollDownTableView(for: indexPath)
        }
    }
    
    
    
    func reloadUI(){
        self.messagesTableView.reloadData()
    }
    
    
    func scrollTopTableView(for indexPath: IndexPath) {
        if lastPerform != Constants.fromSegueShowView.fromWeb{
            self.messagesTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
        }
    }
    
    func scrollDownTableView(for indexPath: IndexPath) {
        if lastPerform != Constants.fromSegueShowView.fromWeb{
            self.messagesTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if chat[1].messages.count == 0{
            return 1
        }
        return 2
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat[section].messages.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return nil
        }
        return sectionsNames[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        let heightOfImage: CGFloat = 350
        cell.timeLabel.text = WorkingVk.translateNSDateToString(date: chat[indexPath.section].messages[indexPath.row].timeNSDate)
        cell.descriptionLabel.text = chat[indexPath.section].messages[indexPath.row].message
        cell.titleLabel.text = chat[indexPath.section].messages[indexPath.row].head
        cell.bubbleIcon.image = chat[indexPath.section].messages[indexPath.row].colorBubble

        if chat[indexPath.section].messages[indexPath.row].typeOfMessage == MessageClass.type.vk{
            cell.imageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].post.group.photoLink))
            if chat[indexPath.section].messages[indexPath.row].post.hasPhoto{
                cell.heightConstraint.constant = heightOfImage
                cell.photoImageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].post.photoLink)!)
            }else{
                cell.heightConstraint.constant = 0
            }
        }else if chat[indexPath.section].messages[indexPath.row].typeOfMessage == MessageClass.type.twitter{
            cell.imageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].tweet.user.photoLink))
            if chat[indexPath.section].messages[indexPath.row].tweet.hasPhoto{
                cell.heightConstraint.constant = heightOfImage
                cell.photoImageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].tweet.photoLink)!)
            }else{
                cell.heightConstraint.constant = 0
            }
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(gesture:)))
        cell.photoImageImageView.isUserInteractionEnabled = true
        cell.photoImageImageView.addGestureRecognizer(tapGestureRecognizer)
        //        let longTap = UILongPressGestureRecognizer(target: self, action: Selector("longPressed"))
        //        cell.textLabel?.addGestureRecognizer(longTap)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
        let url = URL(string: "https://" + chat[indexPath.section].messages[indexPath.row].url)!
        performSegue(withIdentifier: "gotoWeb", sender: url)
    }
    
    func loadNews(){
        //self.activityView.isHidden = true
        DispatchQueue.global(qos: .background).async {
            self.chat[0].messages = WorkingVk.encodePostsToMessages(posts: WorkingVk.getOldPosts())
            self.chat[1].messages = WorkingVk.encodePostsToMessages(posts: WorkingVk.checkNewPosts())
            self.chat[0].messages.append(contentsOf: WorkingTwitter.encodeTweetsToMessages(tweets: WorkingTwitter.getOldTweets()))
            self.chat[1].messages.append(contentsOf: WorkingTwitter.encodeTweetsToMessages(tweets: WorkingTwitter.checkNewTweets()))
            self.chat[0].messages.sort(by: {message1, message2 in
                message1.timeNSDate.isLessThanDate(dateToCompare: message2.timeNSDate)})
            self.chat[1].messages.sort(by: {message1, message2 in
                message1.timeNSDate.isLessThanDate(dateToCompare: message2.timeNSDate)})
            DispatchQueue.main.async {
                self.activityView.isHidden = true
                self.reloadTableView()
                self.isEnabledBackButton(how: true)
            }
        }
        
    }
    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func longPressed(){
        print("long")
    }
    
    func imageTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .ended{
            
        }
    }
    
    func isEnabledBackButton(how: Bool){
        backViewButton.isEnabled = how
    }
    
    
}

extension NotificationsAllViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWeb"{
            if let www = sender as? URL{
                let vc = segue.destination as! WebViewController
                vc.url = www
                self.lastPerform = Constants.fromSegueShowView.fromWeb
            }
        }
    }
}
