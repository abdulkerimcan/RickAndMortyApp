//
//  CharacterDetailsHelper.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit

enum CharacterDetailsHelper {
    static func createCharacterCompostionalLayout(viewModel: CharacterDetailsViewModel) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,_ in
            return createCharacterDetailsSection(viewModel: viewModel, for: sectionIndex)
        }
        
        return layout
    }
    
    static func createCharacterDetailsSection(viewModel: CharacterDetailsViewModel,for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .photo:
            return createPhotoSectionLayout()
        case .information:
            return createInformationSectionLayout()
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
}
