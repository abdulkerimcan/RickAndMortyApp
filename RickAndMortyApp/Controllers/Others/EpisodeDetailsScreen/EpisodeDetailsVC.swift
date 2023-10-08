//
//  EpisodeDetailsVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit

protocol EpisodeDetailsVCProtocol: AnyObject {
    func configureCollectionView()
    func navigateCharacterDetails(character: Character)
}

final class EpisodeDetailsVC: UIViewController {
    private var collectionView: UICollectionView!
    private var viewModel: EpisodeDetailsViewModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    init(viewModel: EpisodeDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodeDetailsVC: EpisodeDetailsVCProtocol {
    func navigateCharacterDetails(character: Character) {
        DispatchQueue.main.async {
            let characterDetailsVC = CharacterDetailsVC(viewModel: CharacterDetailsViewModel(character: character))
            self.navigationController?.pushViewController(characterDetailsVC, animated: true)
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.createDetailsCompostionalLayout(viewModel: viewModel))
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DetailsCharacterCollectionViewCell.self, forCellWithReuseIdentifier: DetailsCharacterCollectionViewCell.identifier)
        collectionView.register(EpisodeDetailsCollectionViewCell.self
                                , forCellWithReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier)
        
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension EpisodeDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .information:
            return 1
        case .character(let viewmodels):
            return viewmodels?.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .information:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier, for: indexPath) as? EpisodeDetailsCollectionViewCell else {
                fatalError()
            }
            cell.setCell(episode: viewModel.episode)
            return cell
        case .character(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCharacterCollectionViewCell.identifier, for: indexPath) as? DetailsCharacterCollectionViewCell,let viewmodels = viewmodels else {
                fatalError()
            }
            cell.setCell(viewModel: viewmodels[indexPath.item])
            return cell
        default:
            let cell = UICollectionViewCell(frame: .zero)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .character(let characters):
            guard let characters = characters else {
                return
            }
            guard let character = characters[indexPath.item].character else {
                return
            }
            viewModel.getDetail(character: character)
        case .information:
            break
        case .photo:
            break
        }
    }
}
