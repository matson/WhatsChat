//
//  LoginViewController.swift
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

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!{
            didSet{
                loginButton.backgroundColor = .clear
                loginButton.layer.cornerRadius = 10
                loginButton.layer.borderWidth = 2
                loginButton.layer.borderColor = UIColor.white.cgColor
                
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult,
                error in
                if let e = error{
                    print(e)
                }else{
                    self?.performSegue(withIdentifier: C.loginSegue, sender: self)
                }
              
                
                
            }
            
        }
        
    }
}

