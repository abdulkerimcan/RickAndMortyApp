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
    func viewDidLoad()
    func fetchEpisodes()
    func fetchAdditionalEpisodes()
}

final class EpisodeViewModel {
    weak var view: EpisodeVCProtocol?
    lazy var service = Service()
    var episodes: [Episode] = []
    var apiInfo: GetAllEpisodes.Info? = nil
    var isLoadingMore = false
}

extension EpisodeViewModel: EpisodeViewModelProtocol {
    func fetchEpisodes() {
        let url = ApiURL.getUrl(endpoint: .episode)
        service.fetch(url: url, expecting: GetAllEpisodes.self) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let model):
                self.episodes.append(contentsOf: model.results)
                self.view?.reloadData()
                self.apiInfo = model.info
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
        view?.configureCollectionView()
        fetchEpisodes()
    }
}
