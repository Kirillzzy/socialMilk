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
        mainImageVIew.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkButtonPressed(_ sender: Any) {
        
    }
    
    func setChecked(how: Bool){
        if how{
            checkButton.setImage(#imageLiteral(resourceName: "checkBoxSet"), for: .normal)
        }else{
            checkButton.setImage(nil, for: .normal)
        }
    }
    
    func isChecked() -> Bool{
        if checkButton.currentImage == #imageLiteral(resourceName: "checkBoxSet"){
            return true
        }
        return false
    }
    
}
