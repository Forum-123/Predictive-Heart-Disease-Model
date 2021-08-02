//
//  AppHelper.swift
//  PredictiveHeartDiseaseApp
//
//  Created by Forum Desai on 23/07/2021.
//  Copyright © 2021 Forum Desai. All rights reserved.
//

import Foundation
import UIKit


class AppHelper: NSObject {
    
    
    class func showAlert(title:String, message:String, target:UIViewController) -> Void {
        let ac = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (cancelAction) in
            
        }
        ac.addAction(okAction)
        target.present(ac, animated: true)
    }
}
