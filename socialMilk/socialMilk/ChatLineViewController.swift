//
//  ChatLineViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class ChatLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messagesTableView: UITableView!

    var chat = ChatClass()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messagesTableView.rowHeight = CGFloat(120)
        reloadTableView()
    }
    
    func reloadTableView(){
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.reloadUI()
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
        cell.timeLabel.text = "00:00"
        cell.descriptionLabel.text = chat.messages[indexPath.row].message
        cell.titleLabel.text = chat.messages[indexPath.row].head
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120
    }

}
