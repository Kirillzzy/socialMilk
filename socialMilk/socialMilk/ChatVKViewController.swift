//
//  ChatLineViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SDWebImage

class ChatVKViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var activityView: UIView!

    var chat = ChatClass()
    private let vk: VKManager = VKManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messagesTableView.estimatedRowHeight = 80
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.global(qos: .background).async {
            self.chat.messages = WorkingVk.createChatByMessages()
            DispatchQueue.main.async {
                self.activityIndicator.hidesWhenStopped = true
                self.activityView.isHidden = true
                self.activityIndicator.stopAnimating()
                self.reloadTableView()
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
    }
    
    func reloadTableView(){
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
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
    //load new messages
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chat.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        cell.timeLabel.text = WorkingVk.translateNSDateToString(date: chat.messages[indexPath.row].time)
        cell.descriptionLabel.text = chat.messages[indexPath.row].message
        cell.titleLabel.text = chat.messages[indexPath.row].head
        cell.imageImageView.sd_setImage(with: URL(string: chat.messages[indexPath.row].post.group.photoLink))
        if chat.messages[indexPath.row].post.hasPhoto{
            cell.photoImageImageView.sd_setImage(with: URL(string: chat.messages[indexPath.row].post.photoLink))
        }else{
            cell.photoImageImageView.isHidden = true
            cell.photoImageImageView.frame = CGRect(x: 0, y: 0, width: CGFloat(0), height: CGFloat(0))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
        let url = URL(string: "http://" + chat.messages[indexPath.row].url)!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:])
        } else {
            UIApplication.shared.openURL(url)
        }
    }


}
