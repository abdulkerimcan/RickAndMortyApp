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
    let character: Character
    private lazy var viewModel = CharacterDetailsViewModel(character: character)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = character._name
        navigationItem.largeTitleDisplayMode = .never
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    init(character: Character) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CharacterDetailsVC: CharacterDetailsVCProtocol {
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: UIHelper.createUICollectionViewCompositionalLayout(viewModel: viewModel))
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailsPhotoCollectionViewCell.self, forCellWithReuseIdentifier: DetailsPhotoCollectionViewCell.identifier)
        collectionView.register(DetailsInformationCollectionViewCell.self, forCellWithReuseIdentifier: DetailsInformationCollectionViewCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension CharacterDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .photo:
            return 1
        case .information(let infos):
            return infos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        
        switch sectionType {
        case .photo:
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsPhotoCollectionViewCell.identifier
                                                                , for: indexPath) as? DetailsPhotoCollectionViewCell else {
                fatalError()
            }
            cell.setCell(model: character)
            return cell
        case .information(let infos):
            guard
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsInformationCollectionViewCell.identifier
                                                                , for: indexPath) as? DetailsInformationCollectionViewCell else {
                fatalError()
            }
            cell.setCell(cellModel: infos[indexPath.item])
            return cell
        }
    }
}