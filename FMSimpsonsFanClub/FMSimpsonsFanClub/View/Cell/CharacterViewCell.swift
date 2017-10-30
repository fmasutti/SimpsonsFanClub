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
    @IBOutlet weak var characterNameLbl: UILabel!
    
    static let cellIdentifier:String = "CharacterCellIdentifier"
    
    func loadCell(character:CharacterViewModel) {
        self.characterNameLbl.text = character.name
    }
}
