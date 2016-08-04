//
//  SignUpViewController.swift
//  ImagePickerWithFirebaseDemo
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    let rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if there is a currently signed in user
        FIRAuth.auth()?.addAuthStateDidChangeListener { auth, user in
            
            if user != nil {
                // User is signed in
                self.performSegueWithIdentifier("showImageSegue", sender: self)
            } else {
                // don't do anything stay on the login page
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func signUpTouched(sender: UIButton) {
        let email : String = emailTextField.text!
        let password : String = passwordTextField.text!
        
        FIRAuth.auth()?.createUserWithEmail(email, password: password) { (user, error) -> Void in
            if(error == nil){
                print(user?.email)
                print(user?.uid)
                self.performSegueWithIdentifier("showImageSegue", sender: self)
            }
            else if (error?.userInfo["error_name"])! as! String == "ERROR_EMAIL_ALREADY_IN_USE"{
                //self.showMessage("Error creating account", message: "This email is already used")
                print(error?.localizedDescription)
            }
        }
    }

}
