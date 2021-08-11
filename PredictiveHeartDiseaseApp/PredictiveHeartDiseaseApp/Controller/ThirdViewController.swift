//
//  ThirdViewController.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 21/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import UIKit
import CoreML
import Firebase

class ThirdViewController: UIViewController {
    
    var predictor = Predictor()
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var caTextField: UITextField!
    @IBOutlet weak var thalachTextField: UITextField!
    @IBOutlet weak var restecgTextField: UITextField!
    @IBOutlet weak var exangTextField: UITextField!
    @IBOutlet weak var oldpeakTextField: UITextField!
    @IBOutlet weak var slopeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func caEntered(_ sender: UITextField) {
        Analytics.logEvent("ca_entered", parameters: ["user_value": sender.text!])
    }
    
    @IBAction func thalachEntered(_ sender: UITextField) {
        Analytics.logEvent("thalach_entered", parameters: ["user_value": sender.text!])
    }
    
    
    @IBAction func restecgEntered(_ sender: UITextField) {
        Analytics.logEvent("restecg_entered", parameters: ["user_value": sender.text!])
    }
    
    @IBAction func exangEntered(_ sender: UITextField) {
        Analytics.logEvent("exang_entered", parameters: ["user_value": sender.text!])
    }
    
    
    @IBAction func oldpeakEntered(_ sender: UITextField) {
        Analytics.logEvent("oldpeak_entered", parameters: ["user_value": sender.text!])
    }
    
    
    @IBAction func slopeEntered(_ sender: UITextField) {
        Analytics.logEvent("slope_entered", parameters: ["user_value": sender.text!])
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func calculateTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
        let currentUserValues = userDefaults.value(forKey: "UserValues") as! NSDictionary
        let mutableUserValues = currentUserValues.mutableCopy() as! NSMutableDictionary
        
        // Checks for any fields that user has not given an input for
        if (caTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert the number of vessels shown in fluoroscopy", target: self);
            return;
        }
        
        if (thalachTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your heart rate", target: self);
            return;
        }
        
        if (restecgTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your ECG results", target: self);
            return;
        }
        
        if (exangTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert if you experience angina during exercise", target: self);
            return;
        }
        
        if (oldpeakTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your ST segment's depression value", target: self);
            return;
        }
        
        if (slopeTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your ST segment's slope value", target: self);
            return;
        }
        
        // Insert values from this page in the existing dictionary
        mutableUserValues.setValue(Double(caTextField.text!)!, forKey: "ca")
        mutableUserValues.setValue(Double(thalachTextField.text!)!, forKey: "thalach")
        mutableUserValues.setValue(Double(restecgTextField.text!)!, forKey: "restecg")
        mutableUserValues.setValue(Double(exangTextField.text!)!, forKey: "exang")
        mutableUserValues.setValue(Double(oldpeakTextField.text!)!, forKey: "oldpeak")
        mutableUserValues.setValue(Double(slopeTextField.text!)!, forKey: "slope")
        
        userDefaults.set(mutableUserValues.copy(), forKey: "UserValues") // Save user values in a dictionary called 'UserValues'
        userDefaults.synchronize()
        Analytics.logEvent("target_generated", parameters: nil)
        
        processValues()
    }
    
    // Reset fields to zero for new values to be entered
    func resetFields () -> Void {
        caTextField.text = ""
        thalachTextField.text = ""
        restecgTextField.text = ""
        exangTextField.text = ""
        oldpeakTextField.text = ""
        slopeTextField.text = ""
    }
    
    // Process all user values into a Double datatype for the model to predict the target value
    func processValues() {
        let userDefaults = UserDefaults.standard
        let currentUserValues = userDefaults.value(forKey: "UserValues") as! NSDictionary
        
        // Values from the first page
        let age = currentUserValues["age"] as! Double
        let sex = currentUserValues["sex"] as! Double
        let cp = currentUserValues["cp"] as! Double
        let trestbps = currentUserValues["trestbps"] as! Double
        let thal = currentUserValues["thal"] as! Double
        
        // Values from the second page
        let chol = currentUserValues["chol"] as! Double
        let fbs = currentUserValues["fbs"] as! Double
        
        // Values from the third page
        let ca = currentUserValues["ca"] as! Double
        let thalach = currentUserValues["thalach"] as! Double
        let restecg = currentUserValues["restecg"] as! Double
        let exang = currentUserValues["exang"] as! Double
        let oldpeak = currentUserValues["oldpeak"] as! Double
        let slope = currentUserValues["slope"] as! Double
        
        let calculateResult = predictor.calculateTarget(age: age, sex: sex, cp: cp, trestbps: trestbps, chol: chol, fbs: fbs, restecg: restecg, thalach: thalach, exang: exang, oldpeak: oldpeak, slope: slope, ca: ca, thal: thal)
        
        // Provide an alert showing the user's result predicted by the model
        let ac = UIAlertController(title: (calculateResult["title"] as! String), message: (calculateResult["message"] as? String), preferredStyle: UIAlertController.Style.alert)
        
        // Once user presses 'OK', all their values are cleared from the dictionary and they are returned to the first page
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (cancelAction) in
            self.dismiss(animated: true, completion: {
                userDefaults.removeObject(forKey: "UserValues")
                userDefaults.synchronize()
                self.resetFields()
            })
        }
        ac.addAction(okAction)
        self.present(ac, animated: true)
    }
}
