//
//  NotificationsFBViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 26/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit
import SafariServices

class NotificationsFBViewController: UIViewController, NotificationsViewControllerProtocol{
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    @IBOutlet weak var progressProgressView: UIProgressView!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!
    
    internal var chat = [ChatClass]()
    internal var sectionsNames = [NSLocalizedString("OldPosts", comment: "OldPostsLabel"),
                                  NSLocalizedString("NewPosts", comment: "NewPostsLabel")]
    internal var lastPerform: Constants.fromSegueShowView = Constants.fromSegueShowView.null
    internal var isWentToWeb = false
    internal let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshTableViewByPulling(sender:)), for: .valueChanged)
        self.messagesTableView.estimatedRowHeight = 80
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.bottomRefreshControl = refreshControl
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        chat.append(ChatClass())
        chat.append(ChatClass())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isWentToWeb{
            isEnabledBackButton(how: false)
            activityView.isHidden = false
            progressProgressView.isHidden = false
            infoLabel.isHidden = true
            infoLabel2.isHidden = true
            updateProgressView(val: 0)
            loadNews()
        }else{
            isWentToWeb = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    internal func reloadTableView(){
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
    
    
    internal func reloadUI(){
        self.messagesTableView.reloadData()
    }
    
    internal func refreshTableViewByPulling(sender: AnyObject){
        loadNewsForPull()
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
        cell.imageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].postFb.group.photoLink))
        if chat[indexPath.section].messages[indexPath.row].postFb.hasPhoto{
            cell.heightConstraint.constant = heightOfImage
            cell.photoImageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].postFb.photoLink)!)
        }else{
            cell.heightConstraint.constant = 0
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(imageTapped(gesture:)))
        cell.photoImageImageView.isUserInteractionEnabled = true
        cell.photoImageImageView.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
        if chat[indexPath.section].messages[indexPath.row].url != ""{
          let url = URL(string: "https://" + chat[indexPath.section].messages[indexPath.row].url)!
          showBrowser(view: self, url: url)
        }
    }
    
    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func loadNews(){
        //self.activityView.isHidden = true
        DispatchQueue.global(qos: .background).async {
            self.chat[0].messages = WorkingFB.encodePostsToMessages(posts: WorkingFB.getOldPosts())
            DispatchQueue.main.async {
                self.updateProgressView(val: 50.0)
            }
            self.chat[1].messages = WorkingFB.encodePostsToMessages(posts: WorkingFB.checkNewPosts())
            DispatchQueue.main.async {
                self.updateProgressView(val: 100.0)
            }
            DispatchQueue.main.async {
                if self.chat[0].messages.count > 0 || self.chat[1].messages.count > 0{
                    self.activityView.isHidden = true
                    self.infoLabel.isHidden = true
                    self.reloadTableView()
                }else{
                    self.loadingImageView.image = nil
                    self.infoLabel.isHidden = false
                    self.infoLabel2.isHidden = false
                }
                self.isEnabledBackButton(how: true)
                self.progressProgressView.isHidden = true
            }
        }
        
    }
    
    func loadNewsForPull(){
        DispatchQueue.global(qos: .background).async {
            var mes0 = [MessageClass]()
            var mes1 = [MessageClass]()
            mes0.append(contentsOf: WorkingFB.encodePostsToMessages(posts: WorkingFB.getOldPosts()))
            mes1.append(contentsOf: WorkingFB.encodePostsToMessages(posts: WorkingFB.checkNewPosts()))
            mes0.sort(by: {message1, message2 in
                message1.timeNSDate.isLessThanDate(dateToCompare: message2.timeNSDate)})
            mes1.sort(by: {message1, message2 in
                message1.timeNSDate.isLessThanDate(dateToCompare: message2.timeNSDate)})
            DispatchQueue.main.async {
                self.chat[0].messages = mes0
                self.chat[1].messages = mes1
                self.reloadUI()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    func imageTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .ended{
            
        }
    }
    
    internal func isEnabledBackButton(how: Bool){
        backViewButton.isEnabled = how
    }
    
    internal func updateProgressView(val: Float){
        progressProgressView.setProgress(val / 100.0, animated: true)
    }
    
}