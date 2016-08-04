//
//  ViewController.swift
//  ImagePickerWithFirebaseDemo
//
//  Created by Carlos Rosario on 8/4/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let rootRef = FIRDatabase.database().reference()
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        rootRef.child("pictures").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            if(snapshot.value != nil){
                if(snapshot.value is NSNull){
                    
                }
                else {
                    
                    let testDictionary = snapshot.value as! [String : AnyObject]
                    
                    for (key, value) in testDictionary{
                        print(key)
                        print(value)
                        
                        let valueArray = value as! [String: String]
                        //print(valueArray["imageURL"])
                        
                        if let url = valueArray["imageURL"] {
                            print(url)
                        }
                        
                        
                    }
                }
            }
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }


    func handleSelectProfileImageView(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true // allows you to crop image before saving
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            avatarImage.image = selectedImage
        }
        
        updateFirebase()
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func showPhotoPicker(sender: UIButton) {
        handleSelectProfileImageView()
    }
    
    private func updateFirebase(){
        // Push image to firebase storage
        let uuid = NSUUID().UUIDString
        let storageRef = FIRStorage.storage().reference().child("profile_images").child(uuid)
        
        if let uploadData = UIImagePNGRepresentation(self.avatarImage.image!){
            // Push image to firebase storage
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    // Push image to firebase database
                    let picturesReference = self.rootRef.child("pictures").childByAutoId()
                    let values = ["imageURL" : profileImageURL]
                    picturesReference.updateChildValues(values){
                        (error, reference) in
                        
                        if(error != nil){
                            print(error)
                            return
                        }
                    }
                }
                
                print(metadata)
            }
        }
    }
}

