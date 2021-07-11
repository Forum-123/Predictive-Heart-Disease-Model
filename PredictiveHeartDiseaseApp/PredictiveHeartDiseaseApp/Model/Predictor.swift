//
//  Predictor.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 11/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

// File responsible for the logic of calculating the target outcome
import UIKit

struct Predictor {
    var target: Target?
    
    func getTarget() -> String {
        let targetInt = String(format: ".0f", target?.value ?? 0.0) // Nil coalescing operator
        return targetInt
    }
    
    func giveAdvice() -> String {
        return target?.advice ?? "No advice" // No advice in case of the optional target being nil
    }
    
    func backgroundColour() -> UIColor {
        return target?.colour ?? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    mutating func calculateTarget() {
        
        let targetOutcome = 0
        
        if targetOutcome == 0 {
            target = Target(value: targetOutcome, advice: "Your chance of having heart disease is low", colour: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        } else {
            target = Target(value: targetOutcome, advice: "Please consult a doctor as a precaution", colour: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1))
        }
    }
}
