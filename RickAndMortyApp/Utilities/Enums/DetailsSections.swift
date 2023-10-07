//
//  EpisodeDetailsSections.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import Foundation

enum DetailsSections {
    case photo
    case information(infos: [CellModel]?)
    case character([LocationDetailsCharacterCellViewModel]?)
}
