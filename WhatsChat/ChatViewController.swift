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
    
    let db = Firestore.firestore()
    
    
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
        
        //loads messages:
        loadMessages()
        
    }
    
    func loadMessages(){
        
       
        //closure
        db.collection(C.FStore.collectionName)
            .order(by: C.FStore.dateField)
            .addSnapshotListener { (querySnapshot, error) in
                
            self.messages = []
                
            if let e = error {
                print("There was an issue retrieving data from FireStore. \(e)")
            }else{
                if let snapshotDocuments = querySnapshot?.documents {
                    for doc in snapshotDocuments {
                        let data = doc.data()
                        if let messageSender = data[C.FStore.senderField] as? String, let messageBody = data[C.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                               
                            //need to fetch the main thread
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                            
                        }
                    }
                }
            }
        }
    }


    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageField.text, let messageSender = Auth.auth().currentUser?.email {
            
            //send to FireStore
            db.collection(C.FStore.collectionName).addDocument(data: [
                C.FStore.senderField: messageSender,
                C.FStore.bodyField: messageBody,
                C.FStore.dateField: Date().timeIntervalSince1970 //need timestamp to order messages.
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to firestore, \(e)")
                }else{
                    print("successfully saved data")
                    self.messageField.text = ""
                }
            }
            
        }
        
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
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: C.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.textLabel?.text = message.body
        
        //This is a message from the current user.
        if message.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = .blue
            cell.label.textColor = .purple
            
        }else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = .gray
            cell.label.textColor = .yellow
            
        }
        
       
        
        
        return cell
    }
    
    
}

