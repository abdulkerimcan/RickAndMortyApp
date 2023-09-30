//
//  EpisodeDetailsHelper.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit

enum EpisodeDetailsHelper {
    static func createEpisodeCompostionalLayout(viewModel: EpisodeDetailsViewModel) -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout {sectionIndex,_ in
            return createEpisodeDetailsSection(viewModel: viewModel, for: sectionIndex)
        }
        
        return layout
    }
    
    static func createEpisodeDetailsSection(viewModel: EpisodeDetailsViewModel,for sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let sectionTypes = viewModel.sections
        switch sectionTypes[sectionIndex] {
        case .information:
            return createInformationSectionLayout()
        case .character:
            return createCharacterSectionLayout()
        }
    }
    
    static func createInformationSectionLayout() -> NSCollectionLayoutSection {
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
    
    static func createCharacterSectionLayout() -> NSCollectionLayoutSection {
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
