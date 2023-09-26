//
//  UIHelper.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 26.09.2023.
//

import UIKit

enum UIHelper {
    static func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        let itemWidth = (CGFloat.dWidth - 30)/2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        return layout
    }
}
