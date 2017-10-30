//
//  PhraseViewModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import UIKit

struct PhraseViewModel {
    var phrase: String!
    var _id: String!
    
    init(phraseModel:PhraseModel) {
        self.phrase = phraseModel.phrase
        self._id = phraseModel._id
    }
    
    static func favoritePhrase(phraseId:String, success successBlock: @escaping ((SavedModel) -> Void), failure failureBlock:((Error?) -> Void)?) {
        Webservice.shared.savePhrases(phraseId: phraseId , success: { (saveModel) in
            successBlock(saveModel)
        }) { (error) in
            
            print("error")
        }
    }
}
