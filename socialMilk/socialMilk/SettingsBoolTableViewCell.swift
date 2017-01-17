//
//  SettingsBoolTableViewCell.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 17/01/2017.
//  Copyright © 2017 Kirill Averyanov. All rights reserved.
//

import UIKit

class SettingsBoolTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
