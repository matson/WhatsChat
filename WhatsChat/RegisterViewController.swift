//
//  RegisterViewController.swift
//  WhatsChat
//
//  Created by Tracy Adams on 5/31/23.
//

import Foundation
import UIKit
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    //make a label would be nice for users. 
                    print(e.localizedDescription)
                }else{
                    //Navigate to the ChatViewController.
                    self.performSegue(withIdentifier: C.registerSegue, sender: self)
                }
            }
        }
    }
    
}

