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
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: SingleLocation?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
    
    var _name : String {
        name ?? "N/A"
    }
    
    var _status : String {
        status?.text ?? "unknown"
    }
    
    var _image: String {
        image ?? "N/A"
    }
}

struct SingleLocation: Codable {
    let name: String?
    let url: String?
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


