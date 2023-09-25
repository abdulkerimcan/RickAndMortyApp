//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation

// MARK: - Result
struct Character: Codable {
    let id: Int?
    let name: String?
    let status: Status?
    let species: Species?
    let type: String?
    let gender: Gender?
    let origin, location: SingleLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

enum Gender: String, Codable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
}

// MARK: - Location
struct SingleLocation: Codable {
    let name: String?
    let url: String?
}

enum Species: String, Codable {
    case alien = "Alien"
    case human = "Human"
}

enum Status: String, Codable {
    case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"

        var text: String {
            switch self {
            case .alive, .dead:
                return rawValue
            case .unknown:
                return "Unknown"
            }
        }
}


