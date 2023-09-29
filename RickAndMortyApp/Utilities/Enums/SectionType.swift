//
//  SectionType.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 28.09.2023.
//

import Foundation

enum SectionType {
    
    case photo
    case information(infos: [CellModel])
    case episodes(episodes: String)
}
