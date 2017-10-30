//
//  PhraseJsonModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

struct PhraseModel: Codable {
    var phrase: String!
    var character: String!
    var _id: String!
    
    static func ==(phrase1: PhraseModel, phrase2: PhraseModel) -> Bool {
        if phrase1._id == phrase2._id &&
            phrase1.character == phrase2.character &&
            phrase1._id == phrase2._id {
            return true
        } else {
            return false
        }
    }
}

