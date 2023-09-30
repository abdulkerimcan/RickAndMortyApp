//
//  EpisodeDetailsVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 30.09.2023.
//

import UIKit

protocol EpisodeDetailsVCProtocol: AnyObject {
    func configureCollectionView()
}

final class EpisodeDetailsVC: UIViewController {
    let episode: Episode
    private var collectionView: UICollectionView!
    lazy var viewModel = EpisodeDetailsViewModel(episode: episode)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = episode.name
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

extension EpisodeDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.sections.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .information:
            return 1
        case .character:
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionType = viewModel.sections[indexPath.section]
        switch sectionType {
        case .information:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier, for: indexPath) as? EpisodeDetailsCollectionViewCell else {
                fatalError()
            }
            cell.backgroundColor = .red
            return cell
            
        case .character:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeDetailsCollectionViewCell.identifier, for: indexPath) as? EpisodeDetailsCollectionViewCell else {
                fatalError()
            }
            cell.backgroundColor = .blue
            return cell
        }
    }
}
