//
//  CharacterModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation

// MARK: - Result
struct Character: Codable,CharacterDataSender {
    
    let id: Int?
    let name: String
    private let status: Status?
    private let species: String?
    private let type: String?
    private let gender: String?
    private let origin: SingleLocation?
    private let location: SingleLocation?
    let image: String
    let episode: [String]?
    let url: String?
    private let created: String?
    
    var _status : String {
        status?.text ?? "N/A"
    }
    
    var _species: String {
        species ?? "N/A"
    }
    
    var _type: String {
        if(type == nil || type!.isEmpty) {
            return "Typeless"
        }
        return type ?? "Typeless"
    }
    
    var _gender: String {
        gender ?? "N/A"
    }
    var _origin: String {
        origin?.name ?? "N/A"
    }
    
    var _location: String {
        location?.name ?? "N/A"
    }
    var _created: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yy"
        guard let date = dateFormatterGet.date(from: created ?? "") else {
            return "N/A"
        }
        let dateString =  dateFormatterPrint.string(from: date)
        return dateString
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


