//
//  NotificationsViewControllerProtocol.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 30/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import UIKit

protocol NotificationsViewControllerProtocol: UITableViewDelegate, UITableViewDataSource{
    weak var messagesTableView: UITableView! {get set}
    weak var activityView: UIView! {get set}
    
    var chat: [ChatClass] {get set}
    var sectionsNames: [String] {get set}
    var lastPerform: Constants.fromSegueShowView {get set}
    
    //    func numberOfSections() -> Int
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    
    func reloadTableView()
    func reloadUI()
    func loadNews()
    func scrollDownTableView(for indexPath: IndexPath)
    func imageTapped(gesture: UITapGestureRecognizer)
    func isEnabledBackButton(how: Bool)
    func updateProgressView(val:Float)
}
