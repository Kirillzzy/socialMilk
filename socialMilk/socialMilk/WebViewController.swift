//
//  WebViewController.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 29/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var backViewButton: UIBarButtonItem!
    
    var url: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadWeb()
    }
    
    private func loadWeb(){
        if let url = url{
            let req = URLRequest(url: url)
            webView.loadRequest(req)
        }
    }
    
    @IBAction func webButtonPressed(_ sender: Any) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:])
        } else {
            UIApplication.shared.openURL(url!)
        }
    }
    
    @IBAction func backViewButtonPressed(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

}
