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

    var chat = [ChatClass]()
    var sectionsNames = ["Old Posts", "New Posts"]
    var lastPerform: Constants.fromSegueShowView = Constants.fromSegueShowView.null
    
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
        let numberOfSections = messagesTableView.numberOfSections
        let numberOfRows = messagesTableView.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            scrollDownTableView(for: indexPath)
        }
    }
    
    
    func reloadUI(){
        self.messagesTableView.reloadData()
    }
    
    func scrollDownTableView(for indexPath: IndexPath) {
        if lastPerform != Constants.fromSegueShowView.fromWeb{
            messagesTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
        let url = URL(string: "https://" + chat[indexPath.section].messages[indexPath.row].url)!
        performSegue(withIdentifier: "gotoWeb", sender: url)
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
            self.chat[1].messages = WorkingVk.encodePostsToMessages(posts: WorkingVk.checkNewPosts())
            DispatchQueue.main.async {
                self.activityView.isHidden = true
                self.reloadTableView()
            }
        }

    }
    
    func imageTapped(gesture: UITapGestureRecognizer){
        if gesture.state == .ended{
            
        }
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
