//
//  ChatsViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatsTableView: UITableView!
    
    var chats = [ChatClass]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        chatsTableView.rowHeight = CGFloat(95)
        _ = VKManager.sharedInstance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chats.removeAll()
        chats.append(ChatClass(chatTitle: "VK",
                               chatImage: #imageLiteral(resourceName: "vkLogoBlack"),
                               chatTime: "Time",
                               chatDescription: "Click to see notifications or wait"))
        
        chats.append(ChatClass(chatTitle: "Twitter",
                               chatImage: #imageLiteral(resourceName: "twitterLogo"),
                               chatTime: "Time",
                               chatDescription: "Click to see notifications or wait"))
        reloadTableView()
    }
    
    func reloadTableView(){
        self.chatsTableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatCell")
        self.reloadUI()
    }
    
    func reloadUI(){
        self.chatsTableView.reloadData()
    }

   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatsTableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        cell.mainImageView.image = chats[indexPath.row].chatImage
        cell.timeLabel.text = chats[indexPath.row].chatTime
        cell.titleLabel.text = chats[indexPath.row].chatTitle
        cell.descriptionLabel.text = chats[indexPath.row].chatDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chatsTableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "fromChatsToChatLineSegue", sender: chats[indexPath.row])
    }


}


extension ChatsViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromChatsToChatLineSegue"{
            if let chat = sender as? ChatClass{
                let vc = segue.destination as! ChatViewController
                vc.chat = chat
            }
        }
    }
}
