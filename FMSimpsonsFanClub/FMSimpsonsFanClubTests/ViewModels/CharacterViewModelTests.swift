//
//  CharacterViewModelTest.swift
//  FMSimpsonsFanClubTests
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest
@testable import FMSimpsonsFanClub

class CharacterViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitCharacterViewModelFromCharacterModel() {
        let characterModel = CharacterModel.init(firstName: "firstName", lastName: "lastName", _id: "dummy", picture: nil)
        var characterViewModel = CharacterViewModel.init(characterModel: characterModel)
        XCTAssert(characterViewModel.name == "firstName lastName")
        XCTAssertNil(characterViewModel.imageUrl)
        
        let characterModelWithValidPicture = CharacterModel.init(firstName: "dummy", lastName: "dummy", _id: "dummy", picture: "anyURL")
        characterViewModel = CharacterViewModel.init(characterModel: characterModelWithValidPicture)
        XCTAssertNotNil(characterViewModel.imageUrl)
    }
}

