//
//  ViewController.swift
//  UIAlertControllerDemo
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func showAlert(sender: UIButton) {
        
        // Create the AlertController
        let alertController = UIAlertController(title: "Hey! :)", message: "I'm an alert.", preferredStyle: .Alert)  // .ActionSheet
        
        // Create the action
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        // Add action to the AlertController
        alertController.addAction(defaultAction)
        
        // Show the alert
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

