//
//  ImageViewController.swift
//  ScrollViewDemoCassini
//
//  Created by student on 7/14/16.
//  Copyright © 2016 rosario. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate {

    private var imageView =  UIImageView()
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentSize = imageView.frame.size
            scrollView.delegate = self
            scrollView.minimumZoomScale = 0.03 //pinch
            scrollView.maximumZoomScale = 1.0  // expand
        }
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    var imageURL: NSURL? {
        didSet{
            image = nil
            
            // Make sure that we are onscreen before trying to fetch a potentially expensive image
            if view.window != nil {
                fetchImage()
            }
            
        }
    }
    
    private func fetchImage() {
        if let url = imageURL{
            
            // This code will run on the "USER_INITIATED QUEUE/THREAD"
            
                spinner?.startAnimating()
                dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
                
                let contentsOfURL = NSData(contentsOfURL: url)
                
                // This code needs to run on the "MAIN QUEUE/THREAD"
                dispatch_async(dispatch_get_main_queue()){ [ weak weakSelf = self] in
                    
                    if url == weakSelf?.imageURL{
                        if let imageData = contentsOfURL{
                            weakSelf?.image = UIImage(data: imageData)
                        } else {
                            weakSelf?.spinner?.stopAnimating()
                        }
                    }
                    else {
                        print ("ignored data returned")
                    }
                }
            }
        }
    }
    
    // Image computed property
    private var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            if ((spinner?.isAnimating()) != nil) {
                spinner?.stopAnimating()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if image == nil {
            fetchImage()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
