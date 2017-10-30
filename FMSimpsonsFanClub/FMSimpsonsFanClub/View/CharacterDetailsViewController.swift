//
//  CharacterDetailsViewController.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 30/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    static let viewControllerIdentifier:String = "CharacterDetailsViewControllerIdentifier"
    var selectedCharacter:CharacterViewModel!
    var phrasesVM: CharacterDetailsViewModel = CharacterDetailsViewModel()
    @IBOutlet weak var characterPhrasesTableView: UITableView!
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var characterNameLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterPhrasesTableView.tableFooterView = UIView()
        self.characterNameLbl.text = self.selectedCharacter.name
        self.loadData()
    }
    
    func loadData() {
        CharacterDetailsViewModel.loadDetails(characterId: self.selectedCharacter._id, success: { (character) in
            self.selectedCharacter = character
            self.selectedCharacter.loadImage(successBlock: { (image) in
                self.characterImg.image = image
            }) { (error) in
                self.errorMessageAlertView()
            }
        }) { (error) in
            self.errorMessageAlertView()
        }
        CharacterDetailsViewModel.loadPhrases(characterId: self.selectedCharacter._id, success: { (phrases) in
            self.phrasesVM = phrases
            self.characterPhrasesTableView.reloadData()
        }) { (error) in
            self.errorMessageAlertView()
        }
    }
    
    func errorMessageAlertView() {
        let alert = UIAlertController(title: "D'OH!", message: "Something went wrong, lets try again!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.loadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// UITableView extension for ViewController
extension CharacterDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableView Delegates.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.phrasesVM.phrases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhraseViewCell.cellIdentifier) as! PhraseViewCell
        cell.loadCell(phrase: self.phrasesVM.phrases[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

