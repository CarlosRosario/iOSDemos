//
//  DemoURL.swift
//  ScrollViewDemoCassini
//
//  Created by Carlos Rosario on 7/14/16.
//  Copyright © 2016 rosario. All rights reserved.
//

import Foundation
struct DemoURL {

    static let NASA = [
        "Cassini" : "http://www.jpl.nasa.gov/images/cassini/20090202/pia03883-full.jpg",
        "Earth": "http://www.nasa.gov/sites/default/files/wave_earth_mosaic_3.jpg",
        "Saturn": "http://www.nasa.gov.sites/default/files/saturn_collage.jpg"
    ]
    
    static func NASAImageNamed(imageName: String?) -> NSURL? {
        if let urlstring = NASA[imageName ?? ""]{
            return NSURL(string: urlstring)
        }
        else {
            return nil
        }
    }
    
}
