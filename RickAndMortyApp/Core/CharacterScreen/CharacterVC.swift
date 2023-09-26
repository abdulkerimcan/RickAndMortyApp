//
//  CharactersVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import UIKit
import SnapKit

protocol CharacterVCProtocol: AnyObject {
    func configureCollectionView()
}

final class CharacterVC: UIViewController {
    lazy var viewModel = CharacterViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension CharacterVC: CharacterVCProtocol {
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero,collectionViewLayout: UIHelper.createLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension CharacterVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}
