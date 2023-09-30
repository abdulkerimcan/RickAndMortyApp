//
//  EpisodeVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import UIKit
import SnapKit

protocol EpisodeVCProtocol: AnyObject {
    func configureCollectionView()
}
final class EpisodeVC: UIViewController {
    lazy var viewModel = EpisodeViewModel()
    private var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episodes"
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension EpisodeVC: EpisodeVCProtocol {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLayout())
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension EpisodeVC: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}


