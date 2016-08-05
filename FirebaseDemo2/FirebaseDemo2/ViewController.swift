//
//  ViewController.swift
//  FirebaseDemo2
//
//  Created by Carlos Rosario on 8/5/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var weatherLabel: UILabel!
    
//    let rootRef = FIRDatabase.database().reference()
    let conditionRef = FIRDatabase.database().reference().child("condition")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        conditionRef.observeEventType(.Value) { (snap: FIRDataSnapshot) in
            self.weatherLabel.text = snap.value?.description
        }
    }
    
    
    @IBOutlet weak var sunnyButtonTouch: UIButton!
    
    
    @IBAction func sunnyTouched(sender: UIButton) {
        conditionRef.setValue("Sunny")
    }
    
    
    @IBAction func foggyTouched(sender: UIButton) {
        conditionRef.setValue("Foggy")
    }
    
}

