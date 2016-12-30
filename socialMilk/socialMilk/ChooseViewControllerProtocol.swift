//
//  ChooseViewControllerProtocol.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 30/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import Foundation
import UIKit

protocol ChooseViewControllerProtocol: UITableViewDelegate, UITableViewDataSource{
    
    weak var blackView: UIView! {get set}
    weak var activityView: UIView! {get set}
    weak var backViewButton: UIBarButtonItem! {get set}
    weak var activityIndicator: UIActivityIndicatorView! {get set}
    
    func reloadTableView()
    func reloadUI()
    
//    func numberOfSections() -> Int
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    func updatePlaces()
    func saveCheckedItems()
    func updateSelfTitle()
    func showLoadingView()
    func hideLoadingView()
}
