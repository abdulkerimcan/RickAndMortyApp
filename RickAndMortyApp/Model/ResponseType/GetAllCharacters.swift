//
//  GetAllCharacters.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import Foundation


struct GetAllCharacters: Codable {
    struct Info: Codable {
            let count: Int?
            let pages: Int?
            let next: String?
            let prev: String?
        }

        let info: Info
        let results: [Character]
}

// MARK: - Info

