//
//  CharacterDetailsViewModelTests.swift
//  FMSimpsonsFanClubTests
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest
@testable import FMSimpsonsFanClub

class CharacterDetailsViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitCharactersViewModelFromPhrases() {
        let phraseModel1 = PhraseModel.init(phrase: "dummy", character: "dummy", _id: "dummy")
        let phraseModel2 = PhraseModel.init(phrase: "dummy", character: "dummy", _id: "dummy")
        let phraseModel3 = PhraseModel.init(phrase: "dummy", character: "dummy", _id: "dummy")
        let characterDetailModelView = CharacterDetailsViewModel.init(phrases: [phraseModel1, phraseModel2, phraseModel3])
        XCTAssert(characterDetailModelView.phrases.count == 3)
    }
}

