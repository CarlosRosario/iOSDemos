//
//  FeedItem.swift
//  PhotoFeed
//
//  Created by Carlos Rosario on 7/21/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import Foundation

// https://api.flickr.com/services/feeds/photos_public.gne?tags=kitten&format=json&nojsoncallback=1

struct FeedItem{
    let title: String
    let imageURL: NSURL
}
