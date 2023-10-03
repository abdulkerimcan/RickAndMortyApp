//
//  GetAllLocations.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import Foundation

struct GetAllLocations: Codable {
    struct Info: Codable {
        let count, pages: Int?
        let next: String?
        let prev: String?
    }
    let info: Info
    let results: [Location]
}
