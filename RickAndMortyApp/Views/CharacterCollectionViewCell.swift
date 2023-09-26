//
//  CharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import UIKit
import SnapKit

final class CharacterCollectionViewCell: UICollectionViewCell {
    static let identifier = "CharacterCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        return image
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.backgroundColor = .orange
        return label
    }()
    
    private let statusLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.backgroundColor = .blue
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView,nameLabel,statusLabel)
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
        nameLabel.text = model._name
        statusLabel.text = model._status
        
    }
}
