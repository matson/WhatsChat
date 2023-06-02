//
//  ChatViewController.swift
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


class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "WhatsChat"
        //hide the back button
        navigationItem.hidesBackButton = true
    }

    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
      
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            //navigate to welcome screen
            navigationController?.popToRootViewController(animated: true)
            
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
}

