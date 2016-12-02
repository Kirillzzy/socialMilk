//
//  ViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class AppsViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func vkButtonPressed(_ sender: Any) {
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }

}

extension AppsViewController{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "fromAppsToChatLineSegue"{
           
        }
    }
}

