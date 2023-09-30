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
    func navigateToDetail(character: Character)
    func reloadData()
}

final class CharacterVC: UIViewController {
    private lazy var viewModel = CharacterViewModel()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
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
        collectionView.register(CharacterCollectionViewCell.self, forCellWithReuseIdentifier: CharacterCollectionViewCell.identifier)
        collectionView.register(FooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterLoadingCollectionReusableView.identifer)
        
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func navigateToDetail(character: Character) {
        DispatchQueue.main.async {
            let detailVC = DetailsVC(character: character)
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
}

extension CharacterVC: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.identifier, for: indexPath) as! CharacterCollectionViewCell
        cell.setCell(model: viewModel.characters[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterLoadingCollectionReusableView.identifer, for: indexPath) as? FooterLoadingCollectionReusableView else {
            return UICollectionReusableView()
        }
        footer.startAnimating()
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
           return CGSize(width: collectionView.frame.width,
                         height: 100)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(index: indexPath.item)
    }
}

extension CharacterVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.isLoadingMore else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
                   let offset = scrollView.contentOffset.y
                   let totalContentHeight = scrollView.contentSize.height
                   let totalScrollViewFixedHeight = scrollView.frame.size.height

                   if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                       self?.viewModel.fetchAdditionalCharacters()
                   }
                   t.invalidate()
               }
    }
}