//
//  LearnViewController.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 11/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import UIKit

class LearnViewController: UIViewController {
    
    var predictor = Predictor()
    
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageSlider: UISlider!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexSlider: UISlider!
    @IBOutlet weak var cpLabel: UILabel!
    @IBOutlet weak var cpTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func ageSliderChanged(_ sender: UISlider) {
        let age = String(format: "%.0f", sender.value)
        ageLabel.text = "\(age) years old"
    }
    
    
    @IBAction func sexSliderChanged(_ sender: UISlider) {
        let sex = String(format: "%.0f", sender.value)
        sexLabel.text = "\(sex)"
    }
    
    
    @IBAction func cpEntered(_ sender: UITextField) {
        let cp = String(format: "%.0f", sender.text ?? 0)
        cpLabel.text = "Level: \(cp)"
    }
    
    
    @IBAction func calculateButtonPressed(_ sender: UIButton) {
        
    }
}
