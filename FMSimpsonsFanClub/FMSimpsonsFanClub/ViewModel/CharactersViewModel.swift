//
//  CharactersViewModel.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation

final class CharactersViewModel {
    
    var characters:[CharacterViewModel] = [CharacterViewModel]()
    
    init() {
        
    }
    
    init(characters:[CharacterModel]) {
        for characterModel in characters {
            self.characters.append(CharacterViewModel.init(characterModel: characterModel))
        }
    }
    
    //Static method that will load at webservice and return
    static func loadCharacters(success successBlock: @escaping ((CharactersViewModel) -> Void), failure failureBlock: ((Error?) -> Void)?) {
        Webservice.shared.getCharacters(success: { (characters) in
            successBlock(CharactersViewModel.init(characters: characters))
        }) { (error) in
            failureBlock?(error)
        }
    }
}
