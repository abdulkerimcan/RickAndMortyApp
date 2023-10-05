//
//  LocationCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import UIKit
import SnapKit

final class LocationCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LocationCollectionViewCell"
    
    private var nameLabel: UILabel = {
       let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        return label
    }()
    private var typeLabel: UILabel = {
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
        typeLabel.text = nil
    }
    
    private func setUI() {
        backgroundColor = .tertiarySystemBackground
        contentView.addSubviews(nameLabel,typeLabel)
        
        nameLabel.snp.makeConstraints { make in make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        typeLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel)
            make.bottom.equalToSuperview().offset(-30)
            make.right.equalToSuperview()
        }
    }
    func setCell(location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
    }
}
