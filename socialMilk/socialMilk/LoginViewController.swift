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
    @IBOutlet weak var fbButton: UIButton!
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
        _ = VKManager.sharedInstance
    }
    
    @IBAction func loginFbButtonPressed(_ sender: Any) {
        FBManager.loginVc(vc: self)
    }

    @IBAction func loginTwitterButtonPressed(_ sender: Any) {
        TwitterManager.login()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        if LoginViewController.loginedAt >= 3{
            WorkingDefaults.setFirstSetupEver(how: false)
            gotoNext()
        }
        if !SetupViewController.isInternetAvailable(){
            showErrorAlert()
        }
    }
    
    private func gotoNext(){
        if SetupViewController.isInternetAvailable(){
            performSegue(withIdentifier: "fromLoginSegue", sender: true)
        }else{
            showErrorAlert()
        }
    }
    
    private func loadComponents(){
        twitterButton.layer.masksToBounds = true
        twitterButton.layer.cornerRadius = 5
        twitterButton.layer.borderWidth = 1
        twitterButton.layer.borderColor = UIColor.white.cgColor
        vkButton.layer.masksToBounds = true
        vkButton.layer.cornerRadius = 5
        vkButton.layer.borderWidth = 1
        vkButton.layer.borderColor = UIColor.white.cgColor
        fbButton.layer.masksToBounds = true
        fbButton.layer.cornerRadius = 5
        fbButton.layer.borderWidth = 1
        fbButton.layer.borderColor = UIColor.white.cgColor
        nextButton.layer.masksToBounds = true
        nextButton.layer.cornerRadius = 5
        nextButton.layer.borderWidth = 1
        nextButton.layer.borderColor = UIColor.white.cgColor
    }
    
    private func showErrorAlert(){
        let alert = UIAlertController(title: NSLocalizedString("ErrorError", comment: "ErrorMessage"),
                                      message: NSLocalizedString("NoInternetError", comment: "ErrorMessage"),
                                      preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OKMessage"), style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

