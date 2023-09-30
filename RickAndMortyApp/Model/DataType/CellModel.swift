//
//  CellModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 29.09.2023.
//

import Foundation

struct CellModel {
    let type: String
    let value: String
    let image: String?
    init(type: String, value: String,image: String?) {
        self.type = type
        self.value = value
        self.image = image
    }
}
