//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var alertError = ErrorAlert()
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                guard error == nil else {
                    self.alertError.showAlert(view: self, title: K.Errors.authErrorTitle, message: error?.localizedDescription ?? K.Errors.errorAlternative)
                    return
                }
                self.performSegue(withIdentifier: K.loginSegue, sender: self)
            }
        }
        
    }
    
}
