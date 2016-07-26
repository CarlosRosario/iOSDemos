//
//  TableViewController.swift
//  XMLParsingTutorial2
//
//  Created by Carlos Rosario on 7/26/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, NSXMLParserDelegate {

    var xmlParser: NSXMLParser!
    var podcasts = [Podcast]()
    
    func refreshPodcasts(){
        let urlString = NSURL(string: "http://www.blubrry.com/feeds/onorte.xml")
        let request: NSURLRequest = NSURLRequest(URL: urlString!)
//        let queue: NSOperationQueue = NSOperationQueue()
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) -> Void in
            if error == nil && data != nil {
                self.xmlParser = NSXMLParser(data: data!)
                self.xmlParser.delegate = self
                self.xmlParser.parse()
                }
            }
        task.resume()
        
//        NSURLConnection.sendAsynchronousRequest(rssUrlRequest, queue: queue){ (response, data, error) -> Void in
//            self.xmlParser = NSXMLParser(data: data!)
//            self.xmlParser.delegate = self
//            self.xmlParser.parse()
//        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshPodcasts()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return podcasts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("basiccell", forIndexPath: indexPath)

        cell.textLabel!.text = podcasts[indexPath.row].podcastTitle
        cell.detailTextLabel?.text = podcasts[indexPath.row].podcastDescription

        return cell
    }
    
    
    
    var entryTitle: String!
    var entryDate: String!
    //var entryURL: PodcastLinkInfo!
    var entryDuration: String!
    var entrySubtitle: String!
    var entryDescription: String!
    var currentParsedElement = String()
    var weAreInsideAnItem = false
    
    // XML parsing delegate methods
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        if elementName == "item"{
            weAreInsideAnItem = true
        }
        
        if weAreInsideAnItem {
            switch elementName {
                case "title":
                    entryTitle = String()
                    currentParsedElement = "title"
                
                case "itunes:summary":
                    entryDescription = String()
                    currentParsedElement = "itunes:summary"
            default: break
            }
        }
        
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if weAreInsideAnItem {
            switch currentParsedElement {
            case "title":
                entryTitle = entryTitle + string
                
            case "itunes:summary":
                entryDescription = entryDescription + string
                
            default: break
            }
        }
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if weAreInsideAnItem {
            switch elementName {
            case "title":
                currentParsedElement = ""
            default:
                currentParsedElement = ""
            }
        }
        
        if elementName == "item" {
            let entryPodcast = Podcast()
            entryPodcast.podcastTitle = entryTitle
            entryPodcast.podcastDescription = entryDescription
            podcasts.append(entryPodcast)
            weAreInsideAnItem = false
        }
    }
    
    func parserDidEndDocument(parser: NSXMLParser) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
    }
    

}
