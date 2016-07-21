//
//  Feed.swift
//  PhotoFeed
//
//  Created by Carlos Rosario on 7/21/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import Foundation

//func fixJsonData (data: NSData) -> NSData {}

class Feed {
    let items: [FeedItem]
    let sourceURL: NSURL
    
    init(items newItems:[FeedItem], sourceURL newURL: NSURL){
        self.items = newItems
        self.sourceURL = newURL
    }
    
    convenience init? (data: NSData, sourceURL url: NSURL){
        var newItems = [FeedItem]()
        
//        let fixedData = fixJsonData(data)
        
        var jsonObject: Dictionary<String, AnyObject>?
        
        do{
            jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? Dictionary<String,AnyObject>
        } catch {
            // error serializing
            print("error serializing json from data")
        }
        
        guard let feedRoot = jsonObject else {
            return nil
        }
        
        guard let items = feedRoot["items"] as? Array<AnyObject> else {
            return nil
        }
        
        for item in items {
            guard let itemDict = item as? Dictionary<String,AnyObject> else {
                continue
            }
            
            guard let media = itemDict["media"] as? Dictionary<String,AnyObject> else {
                continue
            }
            
            guard let urlString = media["m"] as? String else{
                continue
            }
            
            guard let url = NSURL(string: urlString) else {
                continue
            }
            
            let title = itemDict["title"] as? String
            
            newItems.append(FeedItem(title: title ?? "(no title)", imageURL: url))
        }
        self.init(items: newItems, sourceURL: url)
        
        
    }
}
