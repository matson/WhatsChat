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
    @IBOutlet weak var messageField: UITextField!
   
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "what's up?")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = C.appName
        //hide the back button
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        
        //message bubbles:
        tableView.register(UINib(nibName: C.cellNibName, bundle: nil), forCellReuseIdentifier: C.cellIdentifier)
        
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

extension ChatViewController: UITableViewDataSource {
    
    //number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //which tableView cell will show?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.textLabel?.text = messages[indexPath.row].body
        
        
        return cell
    }
    
    
}

