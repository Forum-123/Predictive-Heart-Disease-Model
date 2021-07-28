//
//  FirstViewController.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 21/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import UIKit
import CoreML

class FirstViewController: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageSlider: UISlider!
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

    @IBAction func ageSliderChanged(_ sender: UISlider) {
        let step: Float = 1.0
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        ageLabel.text = String(format: "Age: %.0f yrs old", sender.value)
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
    }
    
    @IBAction func continueTapped(_ sender: UIButton) {
        let userDefaults = UserDefaults.standard
    
        // Checks for any fields that user has not given an input for
        if (ageSlider.value < 1) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your age", target: self);
            return;
        }
        
        if (trestbpsTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your blood pressure", target: self);
            return;
        }
        
        if (cpTextField.text!.isEmpty) {
            AppHelper.showAlert(title: "ERROR", message: "Please insert your chet pain level", target: self);
            return;
        }
        
        let userValues: NSDictionary = [
            "age": Double(ageSlider.value),
            "sex": Double(sexSegmentedControl.selectedSegmentIndex),
            "trestbps": Double(trestbpsTextField.text!)!,
            "cp": Double(cpTextField.text!)!,
            "thal": thalSwitch.isOn ? Double(thalTypeTextField.text!)! : Double(3)
        ];
        
        userDefaults.set(userValues, forKey: "UserValues")  // Save user values in a dictionary called 'UserValues'
        userDefaults.synchronize()
        
        resetFields()
        NotificationCenter.default.post(name: Notification.Name("ShowSecondPage"), object: nil)
    }
    
    // Reset fields to zero for new values to be entered
    func resetFields () -> Void {
        ageSlider.setValue(0, animated: true)
        ageLabel.text = "Age: "
        sexSegmentedControl.selectedSegmentIndex = 0
        trestbpsTextField.text = ""
        cpTextField.text = ""
        thalTypeTextField.text = ""
    }
    
    @IBAction func inputValues() {
    }
}
