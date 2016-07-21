//
//  ImageFeedItemTableViewCell.swift
//  PhotoFeed
//
//  Created by Carlos Rosario on 7/21/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit

class ImageFeedItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLable: UILabel!
    
    weak var dataTask: NSURLSessionDataTask?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
