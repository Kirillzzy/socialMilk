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
        addApps()
        AppsCollectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AppCell")
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


extension AppsViewController{
    func addApps(){
        apps.append(AppClass(AppManager: VKManager(),
                             AppManagerSide: VKManagerWorker(),
                             AppChooseGroupClass: VKChooseGroupClass(),
                             AppPost: VKPost(),
                             AppPostRealm: VKPostRealm(),
                             AppCheckedPost: VKCheckedPost(),
                             AppCheckedPostRealm: VKCheckedPostRealm(),
                             AppRealmManager: RealmManagerVk(),
                             AppWorking: WorkingVk(),
                             AppIcon: #imageLiteral(resourceName: "vkLogoBlackBig"),
                             AppName: "VK"))
        
        apps.append(AppClass(AppManager: TwitterManager(),
                             AppManagerSide: nil,
                             AppChooseGroupClass: TwitterChooseGroupClass(),
                             AppPost: TweetPost(),
                             AppPostRealm: TweetPostRealm(),
                             AppCheckedPost: TweetCheckedPost(),
                             AppCheckedPostRealm: TweetCheckedPostRealm(),
                             AppRealmManager: RealmManagerTwitter(),
                             AppWorking: WorkingTwitter(),
                             AppIcon: #imageLiteral(resourceName: "twitterLogo"),
                             AppName: "Twitter"))
    }

}
