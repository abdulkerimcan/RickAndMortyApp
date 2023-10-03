//
//  LocationDetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import Foundation

protocol LocationDetailsViewModelProtocol {
    var view: LocationDetailsVCProtocol? { get set }
    func viewDidLoad()
    func getDetail(character: Character)
    func setupSections()
}

final class LocationDetailsViewModel {
    weak var view: LocationDetailsVCProtocol?
    var sections: [DetailsSections] = []
    private let location: Location
    
    init(location: Location) {
        self.location = location
        setupSections()
    }
    
}

extension LocationDetailsViewModel: LocationDetailsViewModelProtocol {
    func getDetail(character: Character) {
        view?.navigateCharacterDetails(character: character)
    }
    
    func setupSections() {
        guard let characters = location.residents else {
            return
        }
        sections = [.information,.character(characters.compactMap({
            return DetailsCharacterCellViewModel(characterUrl: URL(string: $0))
        }))]
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
    }
}
