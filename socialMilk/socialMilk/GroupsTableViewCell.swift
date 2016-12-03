//
//  GroupsTableViewCell.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 03/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainImageVIew: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        mainImageVIew.layer.masksToBounds = true
        mainImageVIew.layer.cornerRadius = 50
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        
    }
    
}
