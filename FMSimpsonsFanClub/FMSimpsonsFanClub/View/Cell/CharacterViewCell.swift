//
//  CharacterViewCell.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import UIKit

class CharacterViewCell: UITableViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var imgWidthConstraint: NSLayoutConstraint!
    
    static let cellIdentifier:String = "CharacterCellIdentifier"
    
    func loadCell(character:CharacterViewModel) {
        self.characterName.text = character.name
        
        character.loadImage { (image) in
            self.imageView?.image = image
            UIView.animate(withDuration: 2, animations: {
                self.imgWidthConstraint.constant = 84
                self.contentView.setNeedsLayout()
            })
        }
    }
}
