//
//  DetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 27.09.2023.
//

import Foundation

protocol CharacterDetailsViewModelProtocol {
    var view: CharacterDetailsVCProtocol? {get set}
    func viewDidLoad()
    func setupSection()
}

final class CharacterDetailsViewModel {
    
    weak var view: CharacterDetailsVCProtocol?
    private let character: Character!
    var sections: [SectionType] = []
    init(character: Character) {
        self.character = character
        setupSection()
    }
}



extension CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    
    func setupSection() {
        sections = [.photo,
                                       .information(infos: [
                                        .init(type: "Status", value:
                                                character._status,
                                             image:"heart.fill" ),
                                        .init(type: "Species", value: character._species,
                                             image: "figure.stand"),
                                        .init(type: "Type", value: character._type,
                                             image: "sun.max.fill"),
                                        .init(type: "Gender", value: character._gender,
                                             image: "figure.dress.line.vertical.figure"),
                                        .init(type: "Origin", value: character._origin,
                                             image: "globe.americas.fill"),
                                        .init(type: "Location", value: character._location,image: "globe.americas.fill"),
                                        .init(type: "Cretead", value: character._created,image: "calendar"),
                                        .init(type: "Episodes", value: "\(character.episode?.count ?? 0)",image: "tv")
                                        
                                       ]),]

    }
    

    func viewDidLoad() {
        view?.configureCollectionView()
    }
}
