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
    public func getCharacters(success successBlock: (([CharacterJsonModel]) -> Void)?, failure failureBlock: ((Error?) -> Void)?) {
        Alamofire.request("\( self.baseURL)/\(self.environment)/simpsons/").responseJSON { (response) in
            guard let jsonData = response.data else {
                failureBlock?(response.error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let characters: [CharacterJsonModel] = try jsonDecoder.decode([CharacterJsonModel].self, from: jsonData)
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
    public func getCharacterInfo(characterId:String, success successBlock: ((CharacterJsonModel) -> Void)?, failure failureBlock: ((Error?) -> Void)?) {
        Alamofire.request("\(self.baseURL)/\(self.environment)/simpsons/\(characterId)").responseJSON { (response) in
            guard let jsonData = response.data else {
                failureBlock?(response.error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let characters: CharacterJsonModel = try jsonDecoder.decode(CharacterJsonModel.self, from: jsonData)
                successBlock?(characters)
            } catch {
                failureBlock?(response.error)
            }
        }
    }

}

