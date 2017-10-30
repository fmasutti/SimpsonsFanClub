//
//  PhrasesViewModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

final class CharacterDetailsViewModel {
    
    var character: CharacterViewModel = CharacterViewModel()
    var phrases:[PhraseViewModel] = [PhraseViewModel]()
    
    init() {
        
    }
    
    init(phrases:[PhraseModel]) {
        for phrasesModel in phrases {
            self.phrases.append(PhraseViewModel.init(phraseModel: phrasesModel))
        }
    }
    
    //Static method that will load at webservice and return
    static func loadPhrases(characterId:String, success successBlock: @escaping ((CharacterDetailsViewModel) -> Void), failure failureBlock: ((Error?) -> Void)?) {
        Webservice.shared.getCharacterPhrases(characterId: characterId, success: { (phrases) in
            successBlock(CharacterDetailsViewModel.init(phrases: phrases))
        }) { (error) in
            failureBlock?(error)
        }
    }
    
    static func loadDetails(characterId:String, success successBlock: @escaping ((CharacterViewModel) -> Void), failure failureBlock: ((Error?) -> Void)?) {
        Webservice.shared.getCharacterInfo(characterId: characterId, success: { (characterModel) in
            successBlock(CharacterViewModel.init(characterModel: characterModel))
        }) { (error) in
            failureBlock?(error)
        }
    }
    
}
