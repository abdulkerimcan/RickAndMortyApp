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
    let episode: Episode
    private var collectionView: UICollectionView!
    lazy var viewModel = EpisodeDetailsViewModel(episode: episode)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewModel.view = self
        viewModel.viewDidLoad()
        
    }
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EpisodeDetailsVC: EpisodeDetailsVCProtocol {
    func navigateCharacterDetails(character: Character) {
        DispatchQueue.main.async {
            let characterDetailsVC = CharacterDetailsVC(character: character)
            self.navigationController?.pushViewController(characterDetailsVC, animated: true)
        }
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: EpisodeDetailsHelper.createEpisodeCompostionalLayout(viewModel: viewModel))
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(EpisodeDetailsCharacterCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeDetailsCharacterCollectionViewCell.identifier)
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
            print(viewmodels.count)
            return viewmodels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .information:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier, for: indexPath) as? EpisodeDetailsCollectionViewCell else {
                fatalError()
            }
            cell.setCell(episode: episode)
            return cell
        case .character(let viewmodels):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailsCharacterCollectionViewCell.identifier, for: indexPath) as? EpisodeDetailsCharacterCollectionViewCell else {
                fatalError()
            }
            cell.setCell(viewModel: viewmodels[indexPath.item])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .character(let characters):
            guard let character = characters[indexPath.item].character else {
                return
            }
            viewModel.getDetail(character: character)
        case .information:
            break
        }
    }
}
