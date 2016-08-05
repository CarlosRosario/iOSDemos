//
//  ViewController.swift
//  FirebaseAuthDemo
//
//  Created by Carlos Rosario on 8/5/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signUpTouched(sender: UIButton) {
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) -> Void in
            if(error == nil){
                    print(user?.email)
                    print(user?.uid)
            }
            else {
                print(error?.localizedDescription)
            }
            
        }
    }
    
    
    @IBAction func loginTouched(sender: UIButton) {
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        FIRAuth.auth()?.signInWithEmail(email, password: password) { (user, error) -> Void in
            
            if(error == nil){
                print(user?.email)
                print(user?.uid)
            }
            else {
                print(error?.localizedDescription)
            }
            
        }
    }
    
    
    @IBAction func logoutTouched(sender: UIButton) {
        try! FIRAuth.auth()!.signOut()
    }
    
    
    


}

