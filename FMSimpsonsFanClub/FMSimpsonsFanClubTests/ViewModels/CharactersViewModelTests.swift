//
//  CharactersViewModelTests.swift
//  FMSimpsonsFanClubTests
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest
@testable import FMSimpsonsFanClub

class CharactersViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitCharactersViewModelFromCharactersModel() {
        let charModel1 = CharacterModel.init(firstName: "firstName", lastName: "lastName", _id: "dummy", picture: nil)
        let charModel2 = CharacterModel.init(firstName: "firstName", lastName: "lastName", _id: "dummy", picture: nil)
        let charModel3 = CharacterModel.init(firstName: "firstName", lastName: "lastName", _id: "dummy", picture: nil)
        let charactersViewModel = CharactersViewModel.init(characters: [charModel1, charModel2, charModel3])
        
        XCTAssert(charactersViewModel.characters.count == 3)
    }
}

