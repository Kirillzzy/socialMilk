//
//  LoginViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 18/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var vkButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    static var loginedAt: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadComponents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @IBAction func loginVKButtonPressed(_ sender: Any) {
        //VKManagerWorker.logout()
        _ = VKManager.sharedInstance
    }

    @IBAction func loginTwitterButtonPressed(_ sender: Any) {
        TwitterManager.login()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if LoginViewController.loginedAt >= 2{
            UserDefaults.standard.set(false, forKey: "isFirstSetupEver")
            gotoNext()
        }
    }
    
    func gotoNext(){
        performSegue(withIdentifier: "fromLoginSegue", sender: true)
    }
    
    func loadComponents(){
        twitterButton.layer.masksToBounds = true
        twitterButton.layer.cornerRadius = 5
        vkButton.layer.masksToBounds = true
        vkButton.layer.cornerRadius = 5
    }

}


extension LoginViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromLoginSegue"{
        }
    }
}
