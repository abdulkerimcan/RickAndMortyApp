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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    private var typeLabel: UILabel = {
       let label = UILabel()
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
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        typeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    func setCell(location: Location) {
        nameLabel.text = location.name
        typeLabel.text = location.type
    }
}
