//
//  WebserviceTests.swift
//  FMSimpsonsFanClubTests
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import XCTest
@testable import FMSimpsonsFanClub
import OHHTTPStubs

class WebserviceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        OHHTTPStubs.removeAllStubs()
        super.tearDown()
    }
    
    /**
     * Method that will intercept and stub the backend request that end with the respective provided path, after intercept it, it will provide as response from the server the respective json file.
     *
     * - Parameter path: The end of path from the request that will be stubed from Webservice.
     * - Parameter jsonFile: the stub reponse to use if the request is stubbed
     */
    
    func stubRequestFor(path:String, jsonFile:String) {
        stub(condition: pathEndsWith(path)) { request in
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile(jsonFile, type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )
        }
    }
    
    /**
     * Default expectation that should be called at end of each Async test.
     */
    func waitForRequestToFinish(){
        waitForExpectations(timeout: 10.0) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetCharactersSuccessBlock() {
        let validationExpectation = expectation(description: "Check if return valid character list from 'character_info.json'")
        let expectedCharacterInfo = CharacterModel(firstName: "Moe", lastName: "Sizlack", _id: "59edee68ea392a3947485d41", picture: nil)
        self.stubRequestFor(path: "/simpsons", jsonFile: "characters.json")
        Webservice.shared.getCharacters(success: { (characters) in
            XCTAssert(characters.count == 1)
            XCTAssert(characters.first! == expectedCharacterInfo)
            validationExpectation.fulfill()
        }, failure: nil)
        self.waitForRequestToFinish()
    }
    
    func testGetCharactersFailureBlock() {
        let validationExpectation = expectation(description: "Return error block with invalid Json")
        self.stubRequestFor(path: "/simpsons", jsonFile: "invalid.json")
        Webservice.shared.getCharacters(success:nil, failure: { (error) in
                validationExpectation.fulfill()
            })
        self.waitForRequestToFinish()
    }
    
    func testGetCharactersServerHealth() {
        self.measure {
            Webservice.shared.getCharacters(success: nil, failure: nil)
        }
    }
    
    func testGetCharacterInfoSuccessBlock() {
        let expect = expectation(description: "Compare mocked character and 'character_info.json'")
        let expectedCharacterInfo = CharacterModel(firstName: "Homer", lastName: "Simpson", _id: "59edee68706374dfa957842f", picture: "http://www.trbimg.com/img-573a089a/turbine/ct-homer-simpson-live-pizza-debate-met-0517-20160516")
        self.stubRequestFor(path: expectedCharacterInfo._id, jsonFile: "character_info.json")
        
        Webservice.shared.getCharacterInfo(characterId: expectedCharacterInfo._id, success: { (character) in
            XCTAssert(expectedCharacterInfo == character)
            expect.fulfill()
        }, failure: nil)
        self.waitForRequestToFinish()
    }
    
    func testGetCharacterInfoFailureBlock() {
        let validationExpectation = expectation(description: "Return error block with invalid Json")
        self.stubRequestFor(path: "characterId", jsonFile: "invalid.json")
        Webservice.shared.getCharacterInfo(characterId: "characterId", success: nil) { (error) in
            validationExpectation.fulfill()
        }
        self.waitForRequestToFinish()
    }
    
    func testGetCharacterInfoServerHealth() {
        self.measure {
            Webservice.shared.getCharacterInfo(characterId: "59edee68706374dfa957842f", success: nil, failure: nil)
        }
    }
    
    func testGetCharacterPhrasesSuccessBlock() {
        let validationExpectation = expectation(description: "Return error block with invalid Json")
        let expectedPhrase = PhraseModel.init(phrase: "Now we play the waiting game…Ahh, the waiting game sucks. Let’s play Hungry Hungry Hippos!", character: "59edee68706374dfa957842f", _id: "59edff6492d619b4a933a56b")
        
        self.stubRequestFor(path: "phrases", jsonFile: "phrases.json")
        Webservice.shared.getCharacterPhrases(characterId: "dummy", success: { (phrases) in
            XCTAssert(phrases.count == 2)
            XCTAssert(phrases.last! == expectedPhrase)
            validationExpectation.fulfill()
        }, failure: nil)
        self.waitForRequestToFinish()
    }
    
    func testGetCharacterPhrasesFailureBlock() {
        let validationExpectation = expectation(description: "Return error block with invalid Json")
        self.stubRequestFor(path: "phrases", jsonFile: "invalid.json")
        Webservice.shared.getCharacterPhrases(characterId: "characterId", success: nil) { (error) in
            validationExpectation.fulfill()
        }
        self.waitForRequestToFinish()
    }
    
    func testGetCharacterPhrasesServerHealth() {
        self.measure {
            Webservice.shared.getCharacterPhrases(characterId: "59edee68706374dfa957842f", success: nil, failure: nil)
        }
    }
    
    func testSavePhrasesSuccessBlock() {
        let validationExpectation = expectation(description: "Check for valid saved return")
        let expectedSave = SavedModel.init(status: true, description: "Saved Phrase Success")
        
        self.stubRequestFor(path: "phrase", jsonFile: "phrase_saved.json")
        Webservice.shared.savePhrases(phraseId: "dummy", success: { (saved) in
            XCTAssert(saved == expectedSave)
            validationExpectation.fulfill()
        }, failure: nil)
        self.waitForRequestToFinish()
    }
    
    func testSavePhrasesFailureBlock() {
        let validationExpectation = expectation(description: "Error block with invalid Json")
        self.stubRequestFor(path: "phrase", jsonFile: "invalid.json")
        Webservice.shared.savePhrases(phraseId: "dummy", success: nil) { (error) in
            validationExpectation.fulfill()
        }
        self.waitForRequestToFinish()
    }
    
    func testSavePhrasesServerHealth() {
        self.measure {
            Webservice.shared.savePhrases(phraseId: "dummy", success: nil, failure: nil)
        }
    }
}

