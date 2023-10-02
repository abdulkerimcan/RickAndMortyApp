//
//  Episode.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation

struct Episode: Codable {
    let id: Int?
    let name, air_date, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}
