//
//  Constants.swift
//  WhatsChat
//
//  Created by Tracy Adams on 6/2/23.
//

import Foundation

struct C {
    static let appName = "WhatsChat"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    static let cellIdentifier = "ReuseableCell"
    static let cellNibName = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
