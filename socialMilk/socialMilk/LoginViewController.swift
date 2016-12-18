//
//  LoginViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func loginVKButtonPressed(_ sender: Any) {
        vkDelegateReference = VKManager()
    }

    @IBAction func loginTwitterButtonPressed(_ sender: Any) {
        TwitterManager.login()
    }
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "fromLoginSegue", sender: sender)
    }

}


extension LoginViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromLoginSegue"{

        }
    }
}
