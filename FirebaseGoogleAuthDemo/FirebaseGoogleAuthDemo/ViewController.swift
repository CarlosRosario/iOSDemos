//
//  ViewController.swift
//  FirebaseGoogleAuthDemo
//
//  Created by Carlos Rosario on 8/5/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController, GIDSignInUIDelegate {

    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    @IBAction func signOutTouched(sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        //GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
    }
}

