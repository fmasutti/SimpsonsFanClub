//
//  Webservice.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import Foundation
import Alamofire

final class Webservice {

    private let baseURL = "https://j4g2c85pmf.execute-api.us-east-1.amazonaws.com"
    private let environment: String
    
    static let shared = Webservice.init()
    
    private init() {
        self.environment = "Prod"
//        self.environment = "Develop"
    }
    
    
    /**
     * Async method that will get all characters from webservice.
     *
     * - Parameter successBlock: The Block that will be called with success return from webservice, it contain as well a list with all characters founded.
     * - Parameter failureBlock: The Failure block is called if something went wrong durint this process. It return as well the "error".
     */
    public func getCharacters(success successBlock: (([CharacterModel]) -> Void)?, failure failureBlock: ((Error?) -> Void)?) {
        Alamofire.request("\( self.baseURL)/\(self.environment)/simpsons/").responseJSON { (response) in
            guard let jsonData = response.data else {
                failureBlock?(response.error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let characters: [CharacterModel] = try jsonDecoder.decode([CharacterModel].self, from: jsonData)
                successBlock?(characters)
            } catch {
                failureBlock?(response.error)
            }
        }
    }
    
    /**
     * Async method that will get infos for the character id
     *
     * - Parameter characterId: Id for the character that will be looking for information.
     * - Parameter successBlock: The Block that will be called with success return from webservice, it contain the CharacterModel.
     * - Parameter failureBlock: The Failure block is called if something went wrong durint this process. It return as well the "error".
     */
    public func getCharacterInfo(characterId:String, success successBlock: ((CharacterModel) -> Void)?, failure failureBlock: ((Error?) -> Void)?) {
        Alamofire.request("\(self.baseURL)/\(self.environment)/simpsons/\(characterId)").responseJSON { (response) in
            guard let jsonData = response.data else {
                failureBlock?(response.error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let character: CharacterModel = try jsonDecoder.decode(CharacterModel.self, from: jsonData)
                if character._id != nil {
                    successBlock?(character)
                }else {
                    failureBlock?(response.error)
                }
            } catch {
                failureBlock?(response.error)
            }
        }
    }
    
    /**
     * Async method that will get phrases from respective character id
     *
     * - Parameter characterId: Id for the character that will be looking for phrases.
     * - Parameter successBlock: The Block that will be called with success return from webservice, it contain the PhraseJsonModel array.
     * - Parameter failureBlock: The Failure block is called if something went wrong durint this process. It return as well the "error".
     */
    public func getCharacterPhrases(characterId:String, success successBlock: (([PhraseModel]) -> Void)?, failure failureBlock:((Error?) -> Void)?) {
        Alamofire.request("\(self.baseURL)/\(self.environment)/simpsons/\(characterId)/phrases").responseJSON { (response) in
            guard let jsonData = response.data else {
                failureBlock?(response.error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let characters: [PhraseModel] = try jsonDecoder.decode([PhraseModel].self, from: jsonData)
                successBlock?(characters)
            } catch {
                failureBlock?(response.error)
            }
        }
    }
    
    /**
     * Async method that will save a favorite phrase at webservice.
     *
     * - Parameter phraseId: Id for the phrase that will define as favorite.
     * - Parameter successBlock: The Block that will be called with success return from webservice, it contain the SavedJsonModel.
     * - Parameter failureBlock: The Failure block is called if something went wrong durint this process. It return as well the "error".
     */
    func savePhrases(phraseId:String, success successBlock: ((SavedModel) -> Void)?, failure failureBlock:((Error?) -> Void)?) {
        let parameters = ["phraseId": phraseId]
        let url = "\(self.baseURL)/\(self.environment)/user/phrase"
        Alamofire.request(url, method: .post, parameters: parameters).responseJSON { (response) in
            guard let jsonData = response.data else {
                failureBlock?(response.error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let saved: SavedModel = try jsonDecoder.decode(SavedModel.self, from: jsonData)
                successBlock?(saved)
            } catch {
                failureBlock?(response.error)
            }
        }
    }
    
    
    /**
     * Async method that will Download a respective URL image.
     *
     * - Parameter imagePath: Path for the image that will  be downloaded.
     * - Parameter successBlock: The Block that will be called with success return from webservice, it contain the UIImage.
     * - Parameter failureBlock: The Failure block is called if something went wrong durint this process. It return as well the "error".
     */
    
    func downloadImage(imagePath: String, successBlock: ((UIImage) -> Void)?, failure failureBlock:((Error?) -> Void)?) {
        Alamofire.request(imagePath).responseData { (response) in
            guard let imageData = response.data else {
                failureBlock?(response.error)
                return
            }
            if let image = UIImage(data: imageData) {
                successBlock?(image)
            }else {
                failureBlock?(response.error)
            }
        }
    }
}



