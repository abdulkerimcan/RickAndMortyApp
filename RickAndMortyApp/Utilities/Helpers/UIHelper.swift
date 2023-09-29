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
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let itemWidth = (CGFloat.dWidth - 30)/2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        return layout
    }
    
    static func createUICollectionViewCompositionalLayout(viewModel: DetailsViewModel) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,_ in
            return createSection(viewModel: viewModel, for: sectionIndex)
        }
        
        return layout
    }
    
    static func createSection(viewModel: DetailsViewModel,for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .photo:
            return createPhotoSectionLayout()
        case .information:
            return createInformationSectionLayout()
        case .episodes:
            return createEpisodesSectionLayout() 
        }
        
    }
    
    static func createPhotoSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                             leading: 0,
                                                             bottom: 10,
                                                             trailing: 0)

                let group = NSCollectionLayoutGroup.vertical(
                    layoutSize:  NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(0.5)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                return section
    }
    
    static func createInformationSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.5),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 2,
                    leading: 2,
                    bottom: 2,
                    trailing: 2
                )

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize:  NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .absolute(150)
                    ),
                    subitems: [item, item]
                )
                let section = NSCollectionLayoutSection(group: group)
                return section
    }
    
    
    static func createEpisodesSectionLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1.0),
                        heightDimension: .fractionalHeight(1.0)
                    )
                )
                item.contentInsets = NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 5,
                    bottom: 10,
                    trailing: 8
                )

                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize:  NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(0.8),
                        heightDimension: .absolute(150)
                    ),
                    subitems: [item]
                )
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
    }
}
