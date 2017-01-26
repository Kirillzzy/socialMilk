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
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    private var apps = [AppClass]()
    var isEdit = false

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "back6"))
        AppsCollectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        goToNull()
        refreshCollectionView()
    }
    
    func refreshCollectionView(){
        AppsStaticClass.loadApps()
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
        if let appName = apps[indexPath.row].AppName{
            if !isEdit{
                if appName == "Twitter"{
                    performSegue(withIdentifier: "fromTwitterSegue", sender: self)
                }else if appName == "VK"{
                    performSegue(withIdentifier: "fromVkSegue", sender: self)
                }else if appName == "All"{
                    performSegue(withIdentifier: "fromAllSegue", sender: self)
                }else if appName == "Facebook"{
                    performSegue(withIdentifier: "fromFBSegue", sender: self)
                }
            }else{
                if appName == "Twitter"{
                    WorkingDefaults.setTwitter(how: false)
                }else if appName == "VK"{
                    WorkingDefaults.setVK(how: false)
                }else if appName == "Facebook"{
                    WorkingDefaults.setFB(how: false)
                }
                self.refreshCollectionView()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCell", for: indexPath) as! AppCollectionViewCell
        cell.AppImageView.image = apps[indexPath.row].AppIcon
        cell.AppNameLabel.text = apps[indexPath.row].AppName
        if isEdit && apps[indexPath.row].AppIcon != nil && apps[indexPath.row].AppName != "All"{
            cell.setDeleteToDelete()
        }else{
            cell.setDeleteToNil()
        }
//        let longTap = UITapGestureRecognizer(target:self, action:#selector(longPressed(gesture:)))
//        cell.addGestureRecognizer(longTap)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        isEdit = !isEdit
        if isEdit{
            editButton.title = "Done"
        }else{
            editButton.title = "Edit"
        }
        AppsCollectionView.reloadData()
    }
    
    func goToNull(){
        isEdit = false
        editButton.title = "Edit"
    }
    
    func longPressed(gesture: UILongPressGestureRecognizer){
        
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
        }else if segue.identifier == "fromFBSegue"{
            let vc = segue.destination as! NotificationsFBViewController
            vc.lastPerform = Constants.fromSegueShowView.fromApps
        }
    }
}

