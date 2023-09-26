//
//  Location.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation

struct Location: Codable {
    let id: Int?
    let name, type, dimension: String?
    let residents: [String]?
    let url: String?
    let created: String?
}
