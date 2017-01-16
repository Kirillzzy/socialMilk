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
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back6"))
        FBManager.getUserGroups()
        AppsCollectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apps = AppsStaticClass.apps
        for _ in 0 ..< 8{
            apps.append(AppClass())
        }
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
        }else if apps[indexPath.row].AppName == "All"{
            performSegue(withIdentifier: "fromAllSegue", sender: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCollectionViewCell
        cell.AppImageView.image = apps[indexPath.row].AppIcon
        cell.AppNameLabel.text = apps[indexPath.row].AppName
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(AppsViewController.longPressed))
        cell.addGestureRecognizer(longTap)
        return cell
    }

    @IBAction func editButtonPressed(_ sender: Any) {
        
    }
    
    func longPressed(){
        
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
        }else if segue.identifier == "fromAllSegue"{
            let vc = segue.destination as! NotificationsAllViewController
            vc.lastPerform = Constants.fromSegueShowView.fromApps
        }
    }
}

