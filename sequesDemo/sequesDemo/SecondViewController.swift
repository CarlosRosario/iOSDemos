//
//  SecondViewController.swift
//  sequesDemo
//
//  Created by Carlos Rosario on 7/12/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var viaSegueLabel: UILabel!
    var viaSegue = ""
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        viaSegueLabel.text = viaSegue
    }
}
