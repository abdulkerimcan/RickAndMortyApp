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
    func fetchInitialCharacters()
    func fetchAdditionalCharacters()
}

final class CharacterViewModel {
    weak var view: CharacterVCProtocol?
    lazy var service = Service()
    var apiInfo : GetAllCharacters.Info? = nil
    var characters: [Character] = []
    var isLoadingMore = false
    
}

extension CharacterViewModel: CharacterViewModelProtocol {
    
    func fetchAdditionalCharacters() {
        guard !isLoadingMore else {
            return
        }
        isLoadingMore = true
        guard let urlString = apiInfo?.next else {
            isLoadingMore = false
            return
        }
        service.fetch(url: urlString, expecting: GetAllCharacters.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let model):
                strongSelf.characters.append(contentsOf: model.results)
                strongSelf.apiInfo = model.info
                strongSelf.view?.reloadData()
                strongSelf.isLoadingMore = false
            case .failure(let error):
                self?.isLoadingMore = false
                print(String(describing: error))
            }
        }
    }
    
    func fetchInitialCharacters() {
        let url = ApiURL.getUrl(endpoint: .character)
        service.fetch(url: url, expecting: GetAllCharacters.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let model):
                strongSelf.characters.append(contentsOf: model.results)
                strongSelf.apiInfo = model.info
                strongSelf.view?.reloadData()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
        fetchInitialCharacters()
    }
}
