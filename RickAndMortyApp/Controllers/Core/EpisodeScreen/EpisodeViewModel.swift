//
//  EpisodeViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import Foundation

protocol EpisodeViewModelProtocol {
    var view: EpisodeVCProtocol? {get set}
    func viewDidLoad()
}

final class EpisodeViewModel {
    weak var view: EpisodeVCProtocol?
}

extension EpisodeViewModel: EpisodeViewModelProtocol {
    func viewDidLoad() {
        view?.configureCollectionView()
    }
}
