//
//  ViewController.swift
//  WhatsChat
//
//  Created by Tracy Adams on 5/31/23.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var whatsChat: CLTypingLabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //animation
        whatsChat.text = C.appName
        
        //This code had to be added because of the bug apple still has not fixed?
        
        let newNavBarAppearance = UINavigationBarAppearance()

        // Configuring an opaque background
        //  newNavBarAppearance.configureWithOpaqueBackground()
        // or you can use:
         newNavBarAppearance.configureWithTransparentBackground()
        // when you wanted a configuration with a transparent background
        
        // Navigation bar's background color
        newNavBarAppearance.backgroundColor = .magenta
        
        // Navigation bar's title foreground color
        newNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        // Apply the appearance to different styles:
        navigationController?.navigationBar.scrollEdgeAppearance = newNavBarAppearance
        navigationController?.navigationBar.compactAppearance = newNavBarAppearance
        navigationController?.navigationBar.standardAppearance = newNavBarAppearance
        if #available(iOS 15.0, *) {
            navigationController?.navigationBar.compactScrollEdgeAppearance = newNavBarAppearance
        }
        
        
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
    }
    
    
}

