//
//  AppCollectionViewCell.swift
//  socialMilk
//
//  Created by Kirill Averyanov on 31/12/2016.
//  Copyright © 2016 Kirill Averyanov. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var AppImageView: UIImageView!
    @IBOutlet weak var AppNameLabel: UILabel!
    @IBOutlet weak var deleteItemButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setDeleteToDelete(){
        deleteItemButton.setImage(#imageLiteral(resourceName: "redMinus-1"), for: .normal)
    }
    
    func setDeleteToNil(){
        deleteItemButton.setImage(nil, for: .normal)
    }

    @IBAction func deleteItemButtonPressed(_ sender: Any) {
        if deleteItemButton.currentImage == #imageLiteral(resourceName: "redMinus-1"){
            
        }
    }
    
}
