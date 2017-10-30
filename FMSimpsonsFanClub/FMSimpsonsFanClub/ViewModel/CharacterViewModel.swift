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
    var _id:String!
    
    init() {
        self._id = ""
        self.name = ""
    }
    
    init(characterModel:CharacterModel) {
        self.name = "\(characterModel.firstName!) \(characterModel.lastName!)"
        self.imageUrl = characterModel.picture
        self._id = characterModel._id
    }
    
    public func loadImage(successBlock: ((UIImage) -> Void)?, failure failureBlock:((Error?) -> Void)?) {
        guard let validUrl = self.imageUrl else {
            return
        }
        DispatchQueue.main.async {
            Webservice.shared.downloadImage(imagePath: validUrl, successBlock: successBlock, failure: failureBlock)
        }
    }
}
