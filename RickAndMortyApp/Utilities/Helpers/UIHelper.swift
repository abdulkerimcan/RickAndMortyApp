//
//  UIHelper.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 8.10.2023.
//

import UIKit

extension UIViewController {
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let itemWidth = (CGFloat.dWidth - 30)/2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        return layout
    }
}
