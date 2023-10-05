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
    func getDetail(index: Int)
    func searchCharacter(searchText: String)
    func showSearchButton(shouldShow: Bool)
    func makeSearch(shouldShow: Bool)
}

final class CharacterViewModel {
    weak var view: CharacterVCProtocol?
    lazy var service = Service()
    var apiInfo: GetAllCharacters.Info? = nil
    var characters: [Character] = []
    var isLoadingMore = false
    
}

extension CharacterViewModel: CharacterViewModelProtocol {
    func makeSearch(shouldShow: Bool) {
        view?.makeSearch(shouldShow: shouldShow)
    }
    
    func showSearchButton(shouldShow: Bool) {
        view?.showSearchButton(shouldShow: shouldShow)
    }
    
    func searchCharacter(searchText: String) {
        let url = "\(ApiURL.getUrl(endpoint: .character))/?name=\(searchText)"
        service.fetch(url: url, expecting: GetAllCharacters.self) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.characters = success.results
                self.apiInfo = success.info
                self.view?.reloadData()
            case .failure(let failure):
                self.characters.removeAll()
                self.view?.reloadData()
                print(String(describing: failure))
            }
        }
    }
    
    
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
                strongSelf.isLoadingMore = false
                print(String(describing: error))
            }
        }
    }
    
    func fetchInitialCharacters() {
        let url = ApiURL.getUrl(endpoint: .character)
        service.fetch(url: url, expecting: GetAllCharacters.self) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let model):
                self.characters = model.results
                self.apiInfo = model.info
                self.view?.reloadData()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureUI()
        view?.configureCollectionView()
        fetchInitialCharacters()
    }
    
    func getDetail(index: Int) {
        view?.navigateToDetail(character: characters[index])
    }
    
}
