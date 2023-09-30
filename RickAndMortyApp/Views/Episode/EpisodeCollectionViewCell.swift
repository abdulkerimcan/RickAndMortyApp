//
//  EpisodeCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit
import SnapKit

final class EpisodeCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpisodeCollectionViewCell"
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    
    private var episodeLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        episodeLabel.text = nil
    }
    
    private func setUI() {
        backgroundColor = .tertiarySystemBackground
        addSubviews(nameLabel,episodeLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        episodeLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalToSuperview().offset(-30)
            make.right.equalToSuperview()
        }
        
    }
    
    func setCell(episode: Episode) {
        nameLabel.text = episode.name
        episodeLabel.text = episode.episode
    }
}
