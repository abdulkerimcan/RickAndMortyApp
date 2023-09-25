//
//  ApiURL.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import Foundation

enum ApiURL {
    static func getUrl(endpoint: Endpoints) -> String {
        "https://rickandmortyapi.com/api/\(endpoint)"
    }
}
