//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    var errorAlert = ErrorAlert()
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                guard error == nil else {
                    self.errorAlert.showAlert(view: self, title: K.Errors.authErrorTitle, message: error?.localizedDescription ?? K.Errors.errorAlternative)
                    return
                }
                self.passwordTextfield.text = ""
                self.emailTextfield.text = ""
                self.performSegue(withIdentifier: K.registerSegue, sender: nil)
            }
        } else {
            return
        }
        
    }
    
}
