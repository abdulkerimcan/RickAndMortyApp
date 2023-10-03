//
//  LocationDetailsCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import UIKit
import SnapKit

final class LocationDetailsCollectionViewCell: UICollectionViewCell {
    static let identifier = "LocationDetailsCollectionViewCell"
    private var nameLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    private var typeLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    private var dimensionLabel: UILabel = {
       let label = UILabel()
        
        return label
    }()
    private var createdLabel: UILabel = {
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
        dimensionLabel.text = nil
        createdLabel.text = nil
        
    }
    private func setUI() {
        backgroundColor = .tertiarySystemBackground
        layer.cornerRadius = 10
        addSubviews(nameLabel,typeLabel,dimensionLabel,createdLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.right.equalToSuperview()
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(createdLabel)
        }
        dimensionLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(nameLabel)
            make.right.equalToSuperview()
        }
        createdLabel.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.bottom.equalToSuperview().offset(-10)

        }
        
    }
    func setCell(location: Location) {
        nameLabel.text = "Name: \(location._name)"
        typeLabel.text = "Type: \(location._type)"
        dimensionLabel.text = "Dimension: \(location._dimension)"
        createdLabel.text = "Created: \(location._created)"
    }
}
