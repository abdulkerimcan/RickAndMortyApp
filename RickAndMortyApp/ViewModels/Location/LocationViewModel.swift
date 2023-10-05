//
//  LocationViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import Foundation

protocol LocationViewModelProtocol {
    var view: LocationVCProtocol? { get set }
    func viewDidLoad()
    func fetchInitialLocations()
    func fetchAdditionalLocations()
    func getDetail(index: Int)
    func showSearchButton(shouldShow: Bool)
    func makeSearch(shouldShow: Bool)
    func searchLocation(searchText: String)
    
}

final class LocationViewModel {
    weak var view: LocationVCProtocol?
    private lazy var service = Service()
    var locations: [Location] = []
    var apiInfo: GetAllLocations.Info? = nil
    var isLoadingMore = false
}

extension LocationViewModel: LocationViewModelProtocol {
    func showSearchButton(shouldShow: Bool) {
        view?.showSearchButton(shouldShow: shouldShow)
    }
    
    func makeSearch(shouldShow: Bool) {
        view?.makeSearch(shouldShow: shouldShow)
    }
    
    func searchLocation(searchText: String) {
        let url = "\(ApiURL.getUrl(endpoint: .location))/?name=\(searchText)"
        service.fetch(url: url, expecting: GetAllLocations.self) {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let success):
                self.locations = success.results
                self.apiInfo = success.info
                self.view?.reloadData()
            case .failure(let failure):
                self.locations.removeAll()
                self.view?.reloadData()
                print(String(describing: failure))
            }
        }
    }
    
    func getDetail(index: Int) {
        let location = locations[index]
        view?.navigateToDetail(location: location)
    }
    
    func fetchAdditionalLocations() {
        guard !isLoadingMore else {
            return
        }
        isLoadingMore = true
        guard let urlString = apiInfo?.next else {
            isLoadingMore = false
            return
        }
        service.fetch(url: urlString, expecting: GetAllLocations.self) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let model):
                self.locations.append(contentsOf: model.results)
                self.apiInfo = model.info
                self.view?.reloadData()
                self.isLoadingMore = false
            case .failure(let error):
                isLoadingMore = false
                print(String(describing: error))
            }
        }
    }
    
    func fetchInitialLocations() {
        let url = ApiURL.getUrl(endpoint: .location)
        service.fetch(url: url, expecting: GetAllLocations.self) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let model):
                self.locations = model.results
                self.apiInfo = model.info
                self.view?.reloadData()
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureUI()
        view?.configureCollectionView()
        fetchInitialLocations()
    }
}
