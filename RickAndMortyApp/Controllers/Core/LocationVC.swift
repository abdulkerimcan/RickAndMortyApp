//
//  LocationVC.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import UIKit
import SnapKit

protocol LocationVCProtocol: AnyObject {
    func configureCollectionView()
    func reloadData()
    func navigateToDetail(location: Location)
}
final class LocationVC: UIViewController {

    private var collectionView: UICollectionView!
    private lazy var viewModel = LocationViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Locations"
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension LocationVC: LocationVCProtocol {
    func navigateToDetail(location: Location) {
        DispatchQueue.main.async {
            let detailsVC = LocationDetailsVC()
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createLayout())
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationCollectionViewCell.self, forCellWithReuseIdentifier: LocationCollectionViewCell.identifier)
        collectionView.register(FooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterLoadingCollectionReusableView.identifer)
        
        collectionView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
}

extension LocationVC: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationCollectionViewCell.identifier, for: indexPath) as! LocationCollectionViewCell
        let location = viewModel.locations[indexPath.item]
        cell.setCell(location: location)
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
           return CGSize(width: collectionView.frame.width,
                         height: 100)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(index: indexPath.item)
    }
}

extension LocationVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !viewModel.isLoadingMore else {
            return
        }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
                   let offset = scrollView.contentOffset.y
                   let totalContentHeight = scrollView.contentSize.height
                   let totalScrollViewFixedHeight = scrollView.frame.size.height

                   if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                       self?.viewModel.fetchAdditionalLocations()
                   }
                   t.invalidate()
               }
    }
}
