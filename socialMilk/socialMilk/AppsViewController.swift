//
//  ViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit
import SwiftyVK

class AppsViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollVIew: UIScrollView!
    var chats = [ChatClass]()

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollVIew.contentSize = CGSize(width: 150, height: 150)
    }
    
    @IBAction func vkButtonPressed(_ sender: Any) {
    }
    
    @IBAction func twitterButtonPressed(_ sender: Any) {
    }

}
