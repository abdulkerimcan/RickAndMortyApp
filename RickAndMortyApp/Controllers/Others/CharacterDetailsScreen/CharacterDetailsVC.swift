//
//  DetailsVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 27.09.2023.
//

import UIKit
import SnapKit

protocol CharacterDetailsVCProtocol: AnyObject {
    func configureCollectionView()
    
}

final class CharacterDetailsVC: UIViewController {
    private var collectionView: UICollectionView!
    private var viewModel: CharacterDetailsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = viewModel.character.name
        navigationItem.largeTitleDisplayMode = .never
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    init(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailsVC: CharacterDetailsVCProtocol {
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: self.createDetailsCompostionalLayout(viewModel: viewModel))
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CharacterDetailsPhotoCollectionViewCell.self, forCellWithReuseIdentifier: CharacterDetailsPhotoCollectionViewCell.identifier)
        collectionView.register(CharacterDetailsInformationCollectionViewCell.self, forCellWithReuseIdentifier: CharacterDetailsInformationCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension CharacterDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let infos):
            guard let infos = infos else {
                return 0
            }
            return infos.count
        case .character:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailsPhotoCollectionViewCell.identifier
                                                                , for: indexPath) as? CharacterDetailsPhotoCollectionViewCell else {
                fatalError()
            }
            cell.setCell(model: viewModel.character)
            return cell
        case .information(let infos):
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterDetailsInformationCollectionViewCell.identifier
                                                                , for: indexPath) as? CharacterDetailsInformationCollectionViewCell,let infos = infos else {
                fatalError()
            }
            cell.setCell(cellModel: infos[indexPath.item])
            return cell
        case .character:
            fatalError()
        }
    }
}
