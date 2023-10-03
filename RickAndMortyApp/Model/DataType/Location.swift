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
    
    var _name: String {
        name ?? "N/A"
    }
    var _type: String {
        type ?? "N/A"
    }
    var _dimension: String {
        dimension ?? "N/A"
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
