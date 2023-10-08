//
//  InfoModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 7.10.2023.
//

import Foundation

struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}
