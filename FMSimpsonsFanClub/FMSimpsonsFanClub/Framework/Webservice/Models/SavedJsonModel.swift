//
//  SavedJsonModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

struct SavedJsonModel: Codable {
    var status: Bool!
    var description: String!
    
    static func ==(save1: SavedJsonModel, save2: SavedJsonModel) -> Bool {
        if save1.status == save2.status &&
            save1.description == save2.description {
            return true
        } else {
            return false
        }
    }
}
