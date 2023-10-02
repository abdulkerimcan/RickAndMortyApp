//
//  EpisodeDetailsCharacterViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 1.10.2023.
//

import Foundation
protocol CharacterDataSender {
    var name: String { get }
    var image: String { get }
}

final class EpisodeDetailsCharacterCellViewModel {
    private let characterUrl: URL?
    private var isFetching = false
    private lazy var service = Service()
    var character: Character? {
        didSet {
            guard let model = character else {
                return
            }
            dataBlock?(model)
        }
    }
    private var dataBlock: ((CharacterDataSender) -> Void)?
    
    init(characterUrl: URL?) {
        self.characterUrl = characterUrl
    }
     func registerForData(_ block: @escaping (CharacterDataSender) -> Void) {
            self.dataBlock = block
        }
    
    func fetchCharacter() {
        guard !isFetching else{
            if let model = character {
                    dataBlock?(model)
                }
            return
        }
        guard let characterUrl = characterUrl else {
            return
        }
        isFetching = true
        
        service.fetch(url: characterUrl.absoluteString, expecting: Character.self) { result in
            switch result {
            case .success(let character):
                DispatchQueue.main.async {
                    self.character = character
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension EpisodeDetailsCharacterCellViewModel: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
            hasher.combine(self.characterUrl?.absoluteString ?? "")
        }
    static func == (lhs: EpisodeDetailsCharacterCellViewModel, rhs: EpisodeDetailsCharacterCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    
}
