//
//  Predictor.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 11/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

// File responsible for the logic of calculating the target outcome
import UIKit
import CoreML

var alertTitle: String?
var advice: String?
var values: String?

struct Predictor {
    
    mutating func calculateTarget (
        age:Double, sex:Double, cp:Double, trestbps:Double, chol:Double, fbs:Double, restecg:Double, thalach:Double, exang:Double, oldpeak:Double, slope:Double, ca:Double, thal:Double
        ) -> [String:Any] {
        
        let model: HeartDiseaseCalculator = {
            do {
                let config = MLModelConfiguration()
                return try HeartDiseaseCalculator(configuration: config)
            } catch {
                fatalError("Cannot utilise HeartDiseaseCalculator model")
            }
        }()
        
        guard let mlModelOutput = try? model.prediction(age: age, sex: sex, cp: cp, trestbps: trestbps, chol: chol, fbs: fbs, restecg: restecg, thalach: thalach, exang: exang, oldpeak: oldpeak, slope: slope, ca: ca, thal: thal ) else {
            alertTitle = "Error"
            advice = "There was a problem calculating your prediction."
            return [:]
        }
        
        let targetValue = mlModelOutput.target
        
        // Format some values in the alert
        let gender: String
        if sex == 0 {
            gender = "Female"
        } else {
            gender = "Male"
        }
        
        let bloodSugar: String
        if fbs == 0 {
            bloodSugar = "Less than / equal to 120 mg/dL"
        } else {
            bloodSugar = "More than 120 mg/dL"
        }
            
        values = """
        
        Age: \(Int(age)) years old
        Sex: \(gender)
        Chest Pain: \(Int(cp))
        Blood Pressure: \(Int(trestbps)) mmHg
        Cholesterol: \(Int(chol)) mg/dL
        Blood Sugar Level: \(bloodSugar)
        Resting ECG results: \(Int(restecg))
        Heart rate: \(Int(thalach)) BPM
        Exercise induced angina: \(Int(exang))
        Oldpeak: \(oldpeak)
        Slope: \(Int(slope))
        Vessels shown in fluoroscopy: \(Int(ca))
        Thallium test result: \(Int(thal))
        """
        
        if targetValue == Int64(0) {
            alertTitle = "No Heart Disease"
            advice = "Your chance of having Heart Disease is low, given your results: \(values!)"
        } else {
            alertTitle = "Chance of having Heart Disease"
            advice = "Please consult a doctor as a precaution, given your results: \(values!)"
        }
        return ["title": alertTitle!, "message": advice!]
        
    }
}

