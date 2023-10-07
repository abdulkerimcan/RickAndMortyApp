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
    func reloadData()
    func navigateToDetails(episode: Episode)
    func configureUI()
    func showSearchBar()
    func hideSearchBar()
}
final class EpisodeVC: UIViewController {
    private let searchBar = UISearchBar()
    private var viewModel: EpisodeViewModel
    private var collectionView: UICollectionView!
    
    init(viewModel: EpisodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
    
    @objc func handleShowSearchBar() {
        viewModel.makeSearch()
        searchBar.becomeFirstResponder()
    }
}

extension EpisodeVC: EpisodeVCProtocol {
    func showSearchBar() {
        navigationItem.rightBarButtonItem = nil
        searchBar.showsCancelButton = viewModel.shouldShowSearchBar
        navigationItem.titleView = searchBar
    }
    
    func hideSearchBar() {
        navigationItem.titleView = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        title = "Episodes"
        searchBar.sizeToFit()
        searchBar.delegate = self
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLayout())
        view.addSubview(collectionView)
        collectionView.register(EpisodeCollectionViewCell.self, forCellWithReuseIdentifier: EpisodeCollectionViewCell.identifier)
        collectionView.register(FooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterLoadingCollectionReusableView.identifer)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func navigateToDetails(episode: Episode) {
        DispatchQueue.main.async {
            let detailsVC = EpisodeDetailsVC(viewModel: EpisodeDetailsViewModel(episode: episode))
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

extension EpisodeVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.identifier, for: indexPath)
        as! EpisodeCollectionViewCell
        let episode = viewModel.episodes[indexPath.item]
        cell.setCell(episode: episode)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterLoadingCollectionReusableView.identifer, for: indexPath) as? FooterLoadingCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        if viewModel.apiInfo?.next?.isEmpty == nil {
            footer.stopAnimating()
            
        } else{
            footer.startAnimating()
        }
        return footer
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(index: indexPath.item)
    }
}

extension EpisodeVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.isLoadingMore else {
            
            return
        }
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
                   let offset = scrollView.contentOffset.y
                   let totalContentHeight = scrollView.contentSize.height
                   let totalScrollViewFixedHeight = scrollView.frame.size.height

                   if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                       self?.viewModel.fetchAdditionalEpisodes()
                   }
                   t.invalidate()
               }
    }
}

extension EpisodeVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.cancelButtonClicked()
        searchBar.text = nil
        viewModel.fetchInitialEpisodes()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchEpisode(searchText: searchText)
    }
}
