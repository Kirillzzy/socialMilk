//
//  SetupViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 30/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class SetupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let _ = UserDefaults.standard.object(forKey: "isFirstSetupEver"){
            _ = VKManager.sharedInstance
            TwitterManager.login()
            performSegue(withIdentifier: "toNextSegue", sender: true)
        }else{
            performSegue(withIdentifier: "toLoginSegue", sender: true)
        }
    }

}
