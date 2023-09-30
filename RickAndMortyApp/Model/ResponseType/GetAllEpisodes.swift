//
//  GetAllEpisodes.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import Foundation

struct GetAllEpisodes: Codable {
    struct Info: Codable {
        let count, pages: Int?
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [Episode]
}


