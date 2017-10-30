//
//  CharactersViewController.swift
//  FMSimpsonsFanClub
//
//  Created by Frantiesco Masutti on 29/10/2017.
//  Copyright © 2017 Frantiesco Masutti. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {
    
    var charactersVM: CharactersViewModel = CharactersViewModel()
    @IBOutlet weak var characterTableView: UITableView!
    var selectedCharacter: CharacterViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.characterTableView.tableFooterView = UIView()
        self.loadData()
    }
    
    func loadData() {
        CharactersViewModel.loadCharacters(success: { (charactersViewModel) in
            self.charactersVM = charactersViewModel
            self.characterTableView.reloadData()
        }) { (error) in
            self.errorMessageAlertView()
        }
    }
    
    func errorMessageAlertView() {
        let alert = UIAlertController(title: "D'OH!", message: "Something went wrong, we are going try donwload again the characters list.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (alertAction) in
            self.loadData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! CharacterDetailsViewController
        vc.selectedCharacter = self.selectedCharacter
    }
    
}

// UITableView extension for ViewController
extension CharactersViewController: UITableViewDataSource, UITableViewDelegate {
    // MARK: UITableView Delegates.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charactersVM.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterViewCell.cellIdentifier) as! CharacterViewCell
        cell.loadCell(character: self.charactersVM.characters[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedCharacter = self.charactersVM.characters[indexPath.row]
        performSegue(withIdentifier: CharacterDetailsViewController.viewControllerIdentifier, sender: self)
    }
    
}
