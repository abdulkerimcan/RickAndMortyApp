//
//  EpisodeViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import Foundation
import Alamofire

protocol EpisodeViewModelProtocol {
    var view: EpisodeVCProtocol? {get set}
    var shouldShowSearchBar: Bool {get set}
    func viewDidLoad()
    func fetchInitialEpisodes()
    func fetchAdditionalEpisodes()
    func getDetail(index: Int)
    func searchEpisode(searchText: String)
    func makeSearch()
    func cancelButtonClicked()
}

final class EpisodeViewModel {
    weak var view: EpisodeVCProtocol?
    private lazy var service = Service()
    var episodes: [Episode] = []
    var apiInfo: GetAllEpisodes.Info? = nil
    var isLoadingMore = false
    var shouldShowSearchBar: Bool = false
}

extension EpisodeViewModel: EpisodeViewModelProtocol {
    func cancelButtonClicked() {
        shouldShowSearchBar = false
        view?.hideSearchBar()
    }
    func makeSearch() {
        shouldShowSearchBar = true
        view?.showSearchBar()
    }
    
    func searchEpisode(searchText: String) {
        let url = "\(ApiURL.getUrl(endpoint: .episode))/?name=\(searchText)"
        service.fetch(url: url, expecting: GetAllEpisodes.self) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.episodes = success.results
                self.apiInfo = success.info
                self.view?.reloadData()
            case .failure(let failure):
                self.episodes.removeAll()
                self.view?.reloadData()
                print(String(describing: failure))
            }
        }
    }
    
    func fetchInitialEpisodes() {
        let url = ApiURL.getUrl(endpoint: .episode)
        service.fetch(url: url, expecting: GetAllEpisodes.self) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let model):
                self.episodes = model.results
                self.apiInfo = model.info
                self.view?.reloadData()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    func fetchAdditionalEpisodes() {
        guard !isLoadingMore else {
            return
        }
        isLoadingMore = true
        guard let urlString = apiInfo?.next else {
            isLoadingMore = false
            return
        }
        service.fetch(url: urlString, expecting: GetAllEpisodes.self) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let model):
                self.episodes.append(contentsOf: model.results)
                self.apiInfo = model.info
                self.view?.reloadData()
                self.isLoadingMore = false
            case .failure(let error):
                self.isLoadingMore = false
                print(String(describing: error))
            }
        }
    }
    func viewDidLoad() {
        view?.configureUI()
        view?.configureCollectionView()
        view?.hideSearchBar()
        fetchInitialEpisodes()
    }
    func getDetail(index: Int) {
        view?.navigateToDetails(episode: episodes[index])
    }
}
