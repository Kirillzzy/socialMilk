//
//  ChatLineViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SDWebImage

class NotificationsVKViewController: UIViewController, NotificationsViewControllerProtocol{
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    @IBOutlet weak var progressProgressView: UIProgressView!

    internal var chat = [ChatClass]()
    internal var sectionsNames = ["Old Posts", "New Posts"]
    internal var lastPerform: Constants.fromSegueShowView = Constants.fromSegueShowView.null
    
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
        isEnabledBackButton(how: false)
        self.activityView.isHidden = false
        progressProgressView.isHidden = false
        updateProgressView(val: 0)
        loadNews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func refreshTableView(sender: AnyObject){
        loadNews()
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
        cell.imageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].post.group.photoLink))
        if chat[indexPath.section].messages[indexPath.row].post.hasPhoto{
            cell.heightConstraint.constant = heightOfImage
            cell.photoImageImageView.sd_setImage(with: URL(string: chat[indexPath.section].messages[indexPath.row].post.photoLink)!)
        }else{
            cell.heightConstraint.constant = 0
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
        if WorkingDefaults.getBrowser() == WorkingDefaults.Browser.my{
            performSegue(withIdentifier: "gotoWeb", sender: url)
        }else{
            goWeb(url: url)
        }
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        let deltaOffset = maximumOffset - currentOffset
//        
//        if deltaOffset <= 0 {
//            //loadNews()
//        }
//    }
    
    func loadNews(){
        //self.activityView.isHidden = true
        DispatchQueue.global(qos: .background).async {
            self.chat[0].messages = WorkingVk.encodePostsToMessages(posts: WorkingVk.getOldPosts())
            DispatchQueue.main.async {
                self.updateProgressView(val: 50.0)
            }
            self.chat[1].messages = WorkingVk.encodePostsToMessages(posts: WorkingVk.checkNewPosts())
            DispatchQueue.main.async {
                self.updateProgressView(val: 100.0)
            }
            DispatchQueue.main.async {
                self.activityView.isHidden = true
                self.reloadTableView()
                self.isEnabledBackButton(how: true)
                self.progressProgressView.isHidden = true
            }
        }

    }
    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func longPressed(){
        print("long")
    }
    
    internal func imageTapped(gesture: UITapGestureRecognizer){
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

extension NotificationsVKViewController{
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
