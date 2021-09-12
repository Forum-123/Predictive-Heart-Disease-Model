//
//  FirstViewController.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 21/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import UIKit
import CoreML
import Firebase
import FirebaseAnalytics

class FirstViewController: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageStepper: UIStepper!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexSegmentedControl: UISegmentedControl!
    @IBOutlet weak var trestbpsTextField: UITextField!
    @IBOutlet weak var cpTextField: UITextField!
    @IBOutlet weak var thalSwitch: UISwitch!
    @IBOutlet weak var thalTypeLabel: UILabel!
    @IBOutlet weak var thalTypeDescription: UILabel!
    @IBOutlet weak var thalTypeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showSecondPage), name: Notification.Name("ShowSecondPage"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(showThirdPage), name: Notification.Name("ShowThirdPage"), object: nil)
    }
    
    @objc func showSecondPage(notification: Notification) -> Void {
        let secondPage = self.storyboard?.instantiateViewController(withIdentifier: "secondPage") as! SecondViewController
        self.present(secondPage, animated: true, completion: nil)
    }
    
    @objc func showThirdPage(notification: Notification) -> Void {
        self.dismiss(animated: true) {
            let thirdPage = self.storyboard?.instantiateViewController(withIdentifier: "thirdPage") as! ThirdViewController
            self.present(thirdPage, animated: true, completion: nil)
        }
    }
     
    @IBAction func ageStepperChanged(_ sender: UIStepper) {
        let step: Double = 1.0
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        ageLabel.text = String(format: "Age: %.0f", sender.value)
    }
    
    @IBAction func ageEntered(_ sender: UIStepper) {
        Analytics.logEvent("age_entered", parameters: ["user_value": sender.value])
    }
    
    @IBAction func sexSelected(_ sender: UISegmentedControl) {
        Analytics.logEvent("sex_entered", parameters: ["user_value": sender.selectedSegmentIndex])
    }
    
    @objc func trestbpsEntered(_ sender: UITextField) {
        Analytics.logEvent("trestbps_entered", parameters: ["user_value": sender.text!])
    }
    
    @IBAction func cpEntered(_ sender: UITextField) {
        Analytics.logEvent("cp_entered", parameters: ["user_value": sender.text!])
    }
    
    @IBAction func thalSelected(_ sender: UISwitch) {
        if sender.isOn {
            thalTypeLabel.isEnabled = true
            thalTypeDescription.isEnabled = true
            thalTypeTextField.isEnabled = true
        } else {
            thalTypeLabel.isEnabled = false
            thalTypeDescription.isEnabled = false
            thalTypeTextField.isEnabled = false
        }
        Analytics.logEvent("thal_entered", parameters: nil)
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
    
        // Checks for any fields that user has not given an input for
        if (ageStepper.value == 0) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your age", target: self);
            return;
        }
        
        if (trestbpsTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your blood pressure", target: self);
            return;
        }
        
        if (cpTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your chest pain level", target: self);
            return;
        }
        
        if (thalSwitch.isOn) {
            if (thalTypeTextField.text!.isEmpty) {
                AppHelper.showAlert(title: "ERROR", message: "Please insert your Thallium stress test result", target: self);
                return;
            }
        }
        
        let userValues: NSDictionary = [
            "age": Double(ageStepper.value),
            "sex": Double(sexSegmentedControl.selectedSegmentIndex),
            "trestbps": Double(trestbpsTextField.text!)!,
            "cp": Double(cpTextField.text!)!,
            "thal": thalSwitch.isOn ? Double(thalTypeTextField.text!) as NSDictionary.Value : Double(3)
        ];
        
        userDefaults.set(userValues, forKey: "UserValues")  // Save user values in a dictionary called 'UserValues'
        userDefaults.synchronize()
        
        resetFields()
        NotificationCenter.default.post(name: Notification.Name("ShowSecondPage"), object: nil)
    }
    
    // Reset fields to zero for new values to be entered
    func resetFields () -> Void {
        ageStepper.value = 0
        ageLabel.text = "Age: "
        sexSegmentedControl.selectedSegmentIndex = 0
        trestbpsTextField.text = ""
        cpTextField.text = ""
        thalTypeTextField.text = ""
    }
    
    @IBAction func inputValues() {
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
    {
        // Get URL components from the incoming user activity
        guard userActivity.activityType == NSUserActivityTypeBrowsingWeb,
              let incomingURL = userActivity.webpageURL,
              let components = NSURLComponents(url: incomingURL, resolvingAgainstBaseURL: true)
        else {
            return false
        }
        
        // Check for specific URL components
        guard let path = components.path,
              let params = components.queryItems
        else {
            return false
        }
        print("path = \(path)")
        
        if let modelName = params.first(where: { $0.name == "modelname" })?.value {
            print("model = \(modelName)")
            return true
        } else {
            print("Model name is missing")
            return false
        }
    }
}
