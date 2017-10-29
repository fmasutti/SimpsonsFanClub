//
//  CharacterJsonModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

struct CharacterJsonModel: Codable {
    var firstName: String!
    var lastName: String!
    var _id: String!
    var picture: String?
    
    // to compare 2 CharacterJsonModel.
    static func ==(char1: CharacterJsonModel, char2: CharacterJsonModel) -> Bool {
        if char1.firstName == char2.firstName &&
            char1.lastName == char2.lastName &&
            char1._id == char2._id &&
            (char1.picture == nil && char2.picture == nil) ||
            (char1.picture != nil && char2.picture != nil) && char1.picture == char2.picture {
            return true
        }else {
            return false
        }
    }
}
