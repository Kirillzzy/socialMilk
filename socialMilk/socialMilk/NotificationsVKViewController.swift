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

    var chat = ChatClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesTableView.estimatedRowHeight = 80
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadNews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func reloadTableView(){
        self.reloadUI()
        let numberOfSections = messagesTableView.numberOfSections
        let numberOfRows = messagesTableView.numberOfRows(inSection: numberOfSections - 1)
        if numberOfRows > 0 {
            let indexPath = IndexPath(row: numberOfRows - 1, section: numberOfSections - 1)
            messagesTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
        }
    }
    
    
    func reloadUI(){
        self.messagesTableView.reloadData()
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        let heightOfImage: CGFloat = 350
        cell.timeLabel.text = WorkingVk.translateNSDateToString(date: chat.messages[indexPath.row].timeNSDate)
        cell.descriptionLabel.text = chat.messages[indexPath.row].message
        cell.titleLabel.text = chat.messages[indexPath.row].head
        cell.imageImageView.sd_setImage(with: URL(string: chat.messages[indexPath.row].post.group.photoLink))
        if chat.messages[indexPath.row].post.hasPhoto{
            cell.heightConstraint.constant = heightOfImage
            cell.photoImageImageView.sd_setImage(with: URL(string: chat.messages[indexPath.row].post.photoLink)!)
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
        let url = URL(string: "https://" + chat.messages[indexPath.row].url)!
        performSegue(withIdentifier: "gotoWeb", sender: url)
    }
    
    
    func loadNews(){
        //self.activityView.isHidden = true
        DispatchQueue.global(qos: .background).async {
            self.chat.messages = WorkingVk.createChatByMessages()
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
            }
        }
    }
}
