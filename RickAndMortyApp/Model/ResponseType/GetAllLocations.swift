//
//  GetAllLocations.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import Foundation

struct GetAllLocations: Codable {
    let info: Info
    let results: [Location]
}
