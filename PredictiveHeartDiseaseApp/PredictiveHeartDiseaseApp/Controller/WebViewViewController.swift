//
//  WebViewViewController.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 22/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var myUrl: URL!
        myUrl = URL(string: "https://www.bhf.org.uk/informationsupport/tests/blood-tests/")
        let request = URLRequest(url: myUrl!)
        myWebView.load(request)
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
