//
//  DetailsEpisodesCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 28.09.2023.
//

import UIKit

final class DetailsEpisodesCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailsEpisodesCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
