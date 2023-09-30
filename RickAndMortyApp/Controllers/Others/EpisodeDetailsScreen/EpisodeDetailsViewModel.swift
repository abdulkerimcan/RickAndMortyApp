//
//  EpisodeDetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import Foundation

protocol EpisodeDetailsViewModelProtocol {
    var view: EpisodeDetailsVCProtocol? {get set}
    func viewDidLoad()
}

final class EpisodeDetailsViewModel {
    weak var view: EpisodeDetailsVCProtocol?
    var sections: [EpisodeDetailsSections] = []
    private let episode: Episode
    
    init(episode: Episode) {
        self.episode = episode
        setupSections()
    }
    
}

extension EpisodeDetailsViewModel: EpisodeDetailsViewModelProtocol{
    func viewDidLoad() {
        view?.configureCollectionView()
    }
    func setupSections() {
        sections = [.information,.character]
    }
}
