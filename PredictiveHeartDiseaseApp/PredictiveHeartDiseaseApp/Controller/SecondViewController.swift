//
//  SecondViewController.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 21/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import UIKit
import CoreML
import Firebase

class SecondViewController: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var cholTextField: UITextField!
    @IBOutlet weak var fbsTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cholEntered(_ sender: UITextField) {
        Analytics.logEvent("chol_entered", parameters: nil)
    }
    
    
    @IBAction func fbsEntered(_ sender: UITextField) {
        Analytics.logEvent("fbs_entered", parameters: nil)
    }
    
    @IBAction func websiteClicked(_ sender: UIButton) {
        Analytics.logEvent("website_clicked", parameters: nil)
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        let currentUserValues = userDefaults.value(forKey: "UserValues") as! NSDictionary
        let mutableUserValues = currentUserValues.mutableCopy() as! NSMutableDictionary
        
        // Checks for any fields that user has not given an input for
        if (cholTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your cholesterol level", target: self);
            return;
        }
        
        if (fbsTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your blood sugar level", target: self);
            return;
        }
        
        // Insert values from this page in the existing dictionary
        mutableUserValues.setValue(Double(cholTextField.text!)!, forKey: "chol")
        mutableUserValues.setValue(Double(fbsTextField.text!)!, forKey: "fbs")
        
        userDefaults.set(mutableUserValues.copy(), forKey: "UserValues") // Save user values in a dictionary called 'UserValues'
        userDefaults.synchronize()
        
        resetFields()
        NotificationCenter.default.post(name: Notification.Name("ShowThirdPage"), object: nil)
    }
    
    // Reset fields to zero for new values to be entered
    func resetFields () -> Void {
        cholTextField.text = ""
        fbsTextField.text = ""
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func inputValues() {
    }
}
