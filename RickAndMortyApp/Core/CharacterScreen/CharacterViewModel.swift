//
//  CharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import Foundation

protocol CharacterViewModelProtocol {
    var view: CharacterVCProtocol? {get set}
    func viewDidLoad()
    func fetchAllCharacters()
}

final class CharacterViewModel {
    weak var view: CharacterVCProtocol?
    lazy var service = Service()
    
}

extension CharacterViewModel: CharacterViewModelProtocol {
    func fetchAllCharacters() {
        service.fetch(endpoint: .character, expecting: GetAllCharacters.self) { result in
            switch result {
            case .success(let data):
                break
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
        
    }
}
