//
//  CassiniViewController.swift
//  ScrollViewDemoCassini
//
//  Created by Carlos Rosario on 7/14/16.
//  Copyright © 2016 rosario. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController, UISplitViewControllerDelegate {

    
    // "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg"
    // "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg"
    // "http://www.nasa.gov/sites/default/files/saturn_collage.jpg"
    
    private struct Storyboard {
        static let ShowImageSegue = "Show Image"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        splitViewController?.delegate = self
    }
    
    // This code prevents the detailViewController from showing up first when the app first runs with an empty screen
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if primaryViewController.contentViewController == self {
            if let ivc = secondaryViewController.contentViewController as? ImageViewController where ivc.imageURL == nil {
                return true // lie to system so that detailview doesn't overlay the master
            }
        }
        return false
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == Storyboard.ShowImageSegue {
            if let ivc = segue.destinationViewController.contentViewController as? ImageViewController{
                let imageName = (sender as? UIButton)?.currentTitle
                ivc.imageURL = DemoURL.NASAImageNamed(imageName)
                ivc.title = imageName
            }
        }
    }
}

extension UIViewController {
    var contentViewController: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? self
        }
        else {
            return self
        }
    }
}
