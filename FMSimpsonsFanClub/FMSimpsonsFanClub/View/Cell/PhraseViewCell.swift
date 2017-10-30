//
//  PhraseViewCell.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import UIKit

class PhraseViewCell: UITableViewCell {
    
    @IBOutlet weak var phraseLbl: UILabel!
    var phraseVM:PhraseViewModel!
    
    static let cellIdentifier:String = "PhraseCellIdentifier"
    
    func loadCell(phrase:PhraseViewModel) {
        self.phraseVM = phrase
        self.phraseLbl.text = phrase.phrase
    }
    
    @IBAction func btnFavoriteTouched(_ sender: Any) {
        guard let btn = sender as? UIButton else {
            return
        }
        btn.isEnabled = false
        PhraseViewModel.favoritePhrase(phraseId:  self.phraseVM._id, success: { (saveModel) in
            btn.isEnabled = true
            btn.isHighlighted = true
        }) { (error) in
            btn.isEnabled = true
            btn.isHighlighted = false
        }
    }
    
}

