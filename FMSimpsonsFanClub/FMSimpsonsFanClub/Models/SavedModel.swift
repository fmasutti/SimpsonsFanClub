//
//  SavedModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

struct SavedModel: Codable {
    var status: Bool!
    var description: String!
    
    static func ==(save1: SavedModel, save2: SavedModel) -> Bool {
        if save1.status == save2.status &&
            save1.description == save2.description {
            return true
        } else {
            return false
        }
    }
}
