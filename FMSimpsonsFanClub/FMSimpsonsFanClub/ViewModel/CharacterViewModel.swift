//
//  CharacterViewModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import UIKit

struct CharacterViewModel {
    var name: String!
    var imageUrl:String?
    
    init(characterModel:CharacterModel) {
        self.name = "\(characterModel.firstName!) \(characterModel.lastName!)"
        self.imageUrl = characterModel.picture
    }
    
    public func loadImage(success successBlock: ((UIImage) -> Void)) {
    
    }
}
