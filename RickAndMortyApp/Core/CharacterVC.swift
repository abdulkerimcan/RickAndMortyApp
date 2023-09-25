//
//  CharactersVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import UIKit

final class CharacterVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        
        Service.shared.fetch(endpoint: .character, expecting: GetAllCharacters.self) { result in
            switch result {
            case .success(let character):
                print(character)
            case .failure(let error):
                print(String(describing: error))
            }
        }

        // Do any additional setup after loading the view.
    }
}
