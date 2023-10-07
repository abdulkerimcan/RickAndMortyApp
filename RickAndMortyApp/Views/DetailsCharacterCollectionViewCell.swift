//
//  EpisodeDetailsCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit
import SnapKit
import AlamofireImage

final class DetailsCharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailsCharacterCollectionViewCell"
    
    private var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    private var nameLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10

        clipsToBounds = true
        backgroundColor = .tertiarySystemBackground
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
    }
    
    private func setUI() {
        addSubviews(nameLabel,imageView)
        layer.cornerRadius = 10
        clipsToBounds = true
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(100)
            make.bottom.equalTo(nameLabel.snp.top).offset(-10)
        }
    }
    
    func setCell(viewModel: LocationDetailsCharacterCellViewModel) {
        viewModel.registerForData { [weak self] data in
                    self?.imageView.af.setImage(withURL: URL(string: data.image) ?? URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                                                imageTransition: .crossDissolve(0.8))
                    self?.nameLabel.text = data.name
                }
        viewModel.fetchCharacter()
    }
}
