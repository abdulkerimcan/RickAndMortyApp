//
//  CharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import UIKit
import SnapKit
import AlamofireImage

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let statusLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    private func setUI() {
        contentView.addSubviews(imageView,nameLabel,statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-3)
        }
        nameLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.bottom.equalTo(statusLabel.snp.top).offset(-3)
            make.left.right.equalTo(statusLabel)
        }
        
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-3)
        }
        
    }
    
    func setCell(model: Character) {
        nameLabel.text = model.name
        statusLabel.text = model._status
        imageView.af.setImage(withURL: URL(string: model.image) ?? URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,
                                                            imageTransition: .crossDissolve(0.8)
        )
    }
}
