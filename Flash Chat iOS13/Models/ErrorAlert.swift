//
//  ErrorAlert.swift
//  Flash Chat iOS13
//
//  Created by Jason.Allshorn on 2020/12/01.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct ErrorAlert {
        
    func showAlert(view: UIViewController?, title: String, message: String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay!", style: .default, handler: nil))
        if let controller = view {
            controller.present(alert, animated: true, completion: nil)
        }
    }
}
