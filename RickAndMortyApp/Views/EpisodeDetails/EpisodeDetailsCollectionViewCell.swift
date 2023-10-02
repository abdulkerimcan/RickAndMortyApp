//
//  EpisodeDetailsCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit
import SnapKit

final class EpisodeDetailsCollectionViewCell: UICollectionViewCell {
    static let identifier = "EpisodeDetailsCollectionViewCell"
    
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    
    private var dateLabel: UILabel = {
       let label = UILabel()
        
         label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var episodeLabel: UILabel = {
       let label = UILabel()
        
         label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        setUI()
    }
    override func prepareForReuse() {
        nameLabel.text = nil
        episodeLabel.text = nil
        dateLabel.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        addSubviews(nameLabel,episodeLabel,dateLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        episodeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30)
            make.bottom.equalToSuperview().offset(-30)
        }
        dateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-30)
        }
    }
    
    func setCell(episode: Episode) {
        nameLabel.text = episode.name
        episodeLabel.text = episode.episode
        dateLabel.text = episode.air_date
    }
}
