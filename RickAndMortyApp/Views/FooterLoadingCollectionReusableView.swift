//
//  FooterCollectionReusableView.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 27.09.2023.
//

import UIKit
import SnapKit

final class FooterLoadingCollectionReusableView: UICollectionReusableView {
    static let identifer = "FooterLoadingCollectionReusableView"
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        return spinner
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configureSpinner()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureSpinner() {
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func startAnimating() {
        spinner.startAnimating()
    }
    func stopAnimating() {
        spinner.stopAnimating()
    }
}
