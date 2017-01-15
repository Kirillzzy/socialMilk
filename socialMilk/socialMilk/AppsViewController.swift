//
//  ViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SwiftyVK

class AppsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var AppsCollectionView: UICollectionView!
    
    var apps = [AppClass]()

    override func viewDidLoad() {
        super.viewDidLoad()
        FBManager.getUserGroups()
        AppsCollectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apps = AppsStaticClass.apps
        AppsCollectionView.reloadData()
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppsCollectionView.deselectItem(at: indexPath, animated: true)
        if apps[indexPath.row].AppName == "Twitter"{
            performSegue(withIdentifier: "fromTwitterSegue", sender: self)
        }else if apps[indexPath.row].AppName == "VK"{
            performSegue(withIdentifier: "fromVkSegue", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCollectionViewCell
        cell.AppImageView.image = apps[indexPath.row].AppIcon
        cell.AppNameLabel.text = apps[indexPath.row].AppName
        return cell
    }

    @IBAction func editButtonPressed(_ sender: Any) {
        
    }
}

extension AppsViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromVkSegue"{
            let vc = segue.destination as! NotificationsVKViewController
            vc.lastPerform = Constants.fromSegueShowView.fromApps
        }else if segue.identifier == "fromTwitterSegue"{
            let vc = segue.destination as! NotificationsTwitterViewController
            vc.lastPerform = Constants.fromSegueShowView.fromApps
        }
    }
}

