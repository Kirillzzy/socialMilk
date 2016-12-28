//
//  LoginViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SwiftyVK

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        VK.logIn()
        TwitterManager.login()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gotoNext()
    }
    
    @IBAction func loginVKButtonPressed(_ sender: Any) {
        VK.logIn()
    }

    @IBAction func loginTwitterButtonPressed(_ sender: Any) {
        TwitterManager.login()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        gotoNext()
    }
    
    func gotoNext(){
        performSegue(withIdentifier: "fromLoginSegue", sender: true)
    }

}


extension LoginViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromLoginSegue"{
        }
    }
}
