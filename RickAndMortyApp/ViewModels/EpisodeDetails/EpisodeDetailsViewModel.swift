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
    func getDetail(character: Character)
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
    func getDetail(character: Character) {
        view?.navigateCharacterDetails(character: character)
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
    func setupSections() {
        guard let characters = episode.characters else {
            return
        }
        sections = [.information,.character(characters.compactMap ({
            return EpisodeDetailsCharacterCellViewModel(characterUrl: URL(string: $0))
        }))]
    }
}
