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
    func fetchLocations()
    func fetchAdditionalLocations()
    func getDetail(index: Int)
}

final class LocationViewModel {
    weak var view: LocationVCProtocol?
    private lazy var service = Service()
    var locations: [Location] = []
    var apiInfo: GetAllLocations.Info? = nil
    var isLoadingMore = false
}

extension LocationViewModel: LocationViewModelProtocol {
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
    
    func fetchLocations() {
        let url = ApiURL.getUrl(endpoint: .location)
        service.fetch(url: url, expecting: GetAllLocations.self) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let model):
                self.locations.append(contentsOf: model.results)
                self.view?.reloadData()
                self.apiInfo = model.info
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func viewDidLoad() {
        view?.configureCollectionView()
        fetchLocations()
    }
}
