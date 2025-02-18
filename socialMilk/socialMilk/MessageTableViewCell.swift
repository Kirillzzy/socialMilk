//
//  MessageTableViewCell.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 02/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var photoImageImageView: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bubbleIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageImageView.layer.masksToBounds = true
        imageImageView.layer.cornerRadius = 5
        photoImageImageView.layer.masksToBounds = true
        photoImageImageView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeViewColor(color: UIColor){
        self.contentView.backgroundColor = color
    }
    
}
