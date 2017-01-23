//
//  NotificationsTwitterViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 29/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class NotificationsTwitterViewController: UIViewController, NotificationsViewControllerProtocol{

    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    @IBOutlet weak var progressProgressView: UIProgressView!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!
    
    internal var chat = [ChatClass]()
    internal var sectionsNames = ["Old Posts", "New Posts"]
    internal var lastPerform: Constants.fromSegueShowView = Constants.fromSegueShowView.null
    internal var isWentToWeb = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesTableView.estimatedRowHeight = 80
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
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
        cell.imageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].tweet.user.photoLink))
        if chat[indexPath.section].messages[indexPath.row].tweet.hasPhoto{
            cell.heightConstraint.constant = heightOfImage
            cell.photoImageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].tweet.photoLink)!)
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
        let url = URL(string: "https://" + chat[indexPath.section].messages[indexPath.row].url)!
        if WorkingDefaults.getBrowser() == WorkingDefaults.Browser.my{
            performSegue(withIdentifier: "gotoWeb", sender: url)
        }else{
            goWeb(url: url)
        }
    }
    
    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func loadNews(){
        //self.activityView.isHidden = true
        DispatchQueue.global(qos: .background).async {
            self.chat[0].messages = WorkingTwitter.encodeTweetsToMessages(tweets: WorkingTwitter.getOldTweets())
            DispatchQueue.main.async {
                self.updateProgressView(val: 50.0)
            }
            self.chat[1].messages = WorkingTwitter.encodeTweetsToMessages(tweets: WorkingTwitter.checkNewTweets())
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
    
    func imageTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .ended{
            
        }
    }
    
    internal func isEnabledBackButton(how: Bool){
        backViewButton.isEnabled = how
    }
    
    internal func goWeb(url: URL){
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    internal func updateProgressView(val: Float){
        progressProgressView.setProgress(val / 100.0, animated: true)
    }
    
}

extension NotificationsTwitterViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWeb"{
            if let www = sender as? URL{
                self.isWentToWeb = true
                let vc = segue.destination as! WebViewController
                vc.url = www
                self.lastPerform = Constants.fromSegueShowView.fromWeb
            }
        }
    }
}
