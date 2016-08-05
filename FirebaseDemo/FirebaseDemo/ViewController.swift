//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Carlos Rosario on 8/5/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    var remoteConfig: FIRRemoteConfig!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfig = FIRRemoteConfig.remoteConfig()
        
        let devModeSettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        remoteConfig.configSettings = devModeSettings!

        let defaultValues = ["buttonText" : "Click Me", "loading": "loading.."]
        FIRRemoteConfig.remoteConfig().setDefaults(defaultValues)

        fetchRemoteConfig()
    }
    
    
    @IBAction func fetchConfigs(sender: UIButton) {
        fetchRemoteConfig()
    }
    
    
    func updateView(){
        let rc = FIRRemoteConfig.remoteConfig()
        let buttonText = rc.configValueForKey("buttonText").stringValue
        print("ButtonText: " + buttonText!)
        button.setTitle(buttonText, forState: .Normal)
    }
    
    func fetchRemoteConfig(){

        button.setTitle(remoteConfig["loading"].stringValue, forState: .Normal)
        
        var expirationDuration = 3600
        
        if(remoteConfig.configSettings.isDeveloperModeEnabled){
            expirationDuration = 0
        }
        
        remoteConfig.fetchWithExpirationDuration(NSTimeInterval(expirationDuration)) { (status, error) -> Void in
            if (status == FIRRemoteConfigFetchStatus.Success){
                print("Config fetched!")
                self.remoteConfig.activateFetched()
            }
            else {
                print("Config not fetched")
                print("Error \(error!.localizedDescription)")
                
            }
            self.updateView()
        }
        
        
        
//        weak var weakSelf = self
//        let expirationTime : NSTimeInterval = 0.0
//        FIRRemoteConfig.remoteConfig().fetchWithExpirationDuration(expirationTime) { (status, error) -> Void in
//            if(error == nil){
//                print("Hooray! Config completed with status " + String(status.rawValue))
//                FIRRemoteConfig.remoteConfig().activateFetched()
//                weakSelf!.updateView()
//            }
//            else {
//                print("Oh no we have an error!")
//            }
//        }
        
        
    }

}

