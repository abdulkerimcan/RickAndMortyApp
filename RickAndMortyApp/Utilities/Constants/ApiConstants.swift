//
//  ApiURL.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import Foundation

final class ApiConstants {
    
    private let baseUrl = "https://rickandmortyapi.com/api/"
    
    let constantImageUrl = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!
    
    static let shared = ApiConstants()
    
    private init() {}
    
    func getUrl(endpoint: Endpoints) -> String {
        "\(baseUrl)\(endpoint)"
    }
}
