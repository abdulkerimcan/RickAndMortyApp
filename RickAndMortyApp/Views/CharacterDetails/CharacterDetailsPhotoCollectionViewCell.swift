//
//  DetailsPhotoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 28.09.2023.
//

import UIKit
import AlamofireImage
import SnapKit

final class CharacterDetailsPhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailsPhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
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
        imageView.image = nil
    }
    
    private func setUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func setCell(model: Character) {
        imageView.af.setImage(withURL: URL(string: model.image) ?? URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")!,imageTransition: .crossDissolve(0.8))
    }
}
