//
//  NotificationsAllViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 16/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit


class NotificationsAllViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    @IBOutlet weak var progressProgressView: UIProgressView!
    @IBOutlet weak var loadingImageView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoLabel2: UILabel!
    internal let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl.addTarget(self, action: #selector(refreshTableViewByPulling(sender:)), for: .valueChanged)
        self.messagesTableView.estimatedRowHeight = 90
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.bottomRefreshControl = refreshControl
        self.messagesTableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
    }
    
    internal func refreshTableViewByPulling(sender: AnyObject){
    }
    
    
    internal func reloadUI(){
        self.messagesTableView.reloadData()
    }
    
    
    func scrollTopTableView(for indexPath: IndexPath) {
        self.messagesTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.top, animated: false)
    }
    
    func scrollDownTableView(for indexPath: IndexPath) {
        self.messagesTableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messagesTableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        messagesTableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    internal func isEnabledBackButton(how: Bool){
        backViewButton.isEnabled = how
    }
    
    
    internal func updateProgressView(val: Float){
        progressProgressView.setProgress(val / 100.0, animated: true)
    }
    
}
