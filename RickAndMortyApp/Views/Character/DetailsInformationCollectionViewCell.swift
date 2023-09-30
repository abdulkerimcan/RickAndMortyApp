//
//  DetailsInformationCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 28.09.2023.
//

import UIKit
import SnapKit

final class DetailsInformationCollectionViewCell: UICollectionViewCell {
    static let identifier = "DetailsInformationCollectionViewCell"
    
    private var valueLabel: UILabel = {
       let label = UILabel()
        label.font = .monospacedDigitSystemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    private var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill

        return image
    }()
    
    private var typeLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
                label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .tertiarySystemBackground
        layer.cornerRadius = 10
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUI() {
        addSubviews(typeLabel,valueLabel,image)
        
        typeLabel.backgroundColor = .secondarySystemBackground
        typeLabel.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
        }
        
        valueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(image.snp.right).offset(10)
        }
        
        image.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(30)
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
        }
    }
    
    func setCell(cellModel: CellModel) {
        typeLabel.text = cellModel.type.uppercased()
        valueLabel.text = cellModel.value.uppercased()
        image.image = UIImage(systemName: cellModel.image)
    }
}
