//
//  StoryTableViewCell.swift
//  ParseStarterProject-Swift
//
//  Created by Tao Liu on 9/1/15.
//  Copyright (c) 2015 Parse. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet weak var sourceLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var shareButton: SpringButton!
    
    @IBOutlet weak var commentButton: SpringButton!
    
    @IBOutlet weak var favouriteButton: SpringButton!
    
    @IBAction func shareButtonDidTouch(sender: SpringButton) {
        shareButton.animation = "pop"
        shareButton.animate()
    }
    
    @IBAction func commentButtonDidTouch(sender: SpringButton) {
        commentButton.animation = "pop"
        commentButton.animate()
    }
    
    @IBAction func favouriteButtonDidTouch(sender: SpringButton) {
        favouriteButton.animation = "pop"
        favouriteButton.animate()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //sourceLabel.preferredMaxLayoutWidth = 300
        titleLabel.preferredMaxLayoutWidth = 300
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    
    
    
    
}
