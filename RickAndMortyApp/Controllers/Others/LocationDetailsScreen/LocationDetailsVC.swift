//
//  LocationDetailsVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import UIKit
import SnapKit


protocol LocationDetailsVCProtocol: AnyObject {
    func configureCollectionView()
    func navigateCharacterDetails(character: Character)
}

final class LocationDetailsVC: UIViewController {
    private var viewmodel: LocationDetailsViewModel
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewmodel.view = self
        viewmodel.viewDidLoad()
    }
    
    init(viewmodel: LocationDetailsViewModel) {
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LocationDetailsVC: LocationDetailsVCProtocol {
    func navigateCharacterDetails(character: Character) {
        DispatchQueue.main.async {
            let characterDetailsVC = CharacterDetailsVC(viewModel: CharacterDetailsViewModel(character: character))
            self.navigationController?.pushViewController(characterDetailsVC, animated: true)
        }
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createDetailsCompostionalLayout(viewModel: viewmodel))
        view.addSubview(collectionView)
        collectionView.register(LocationDetailsCollectionViewCell.self, forCellWithReuseIdentifier: LocationDetailsCollectionViewCell.identifier)
        collectionView.register(DetailsCharacterCollectionViewCell.self, forCellWithReuseIdentifier: DetailsCharacterCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
}

extension LocationDetailsVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewmodel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewmodel.sections[section]
        switch sectionType {
            
        case .information:
            return 1
            
        case .character(let viewmodels):
            return viewmodels?.count ?? 0
            
        case .photo:
            return 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewmodel.sections[indexPath.section]
        switch sectionType {
            
        case .information:
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationDetailsCollectionViewCell.identifier, for: indexPath) as? LocationDetailsCollectionViewCell else {
                fatalError()
            }
            cell.setCell(location: viewmodel.location)
            return cell
            
        case .character(let viewmodels):
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCharacterCollectionViewCell.identifier, for: indexPath) as? DetailsCharacterCollectionViewCell,let viewmodels = viewmodels else {
                fatalError()
            }
            cell.setCell(viewModel: viewmodels[indexPath.item])
            return cell
            
        case .photo:
            fatalError()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewmodel.sections[indexPath.section]
        switch sectionType {
        case .character(let characters):
            guard let characters = characters else {
                return
            }
            guard let character = characters[indexPath.item].character else {
                return
            }
            viewmodel.getDetail(character: character)
        case .information:
            break
        case .photo:
            break
        }
    }
}
