//
//  LocationViewModel.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 3.10.2023.
//

import Foundation

protocol LocationViewModelProtocol {
    var view: LocationVCProtocol? { get set }
    var shouldShowSearchBar: Bool {get set}
    func viewDidLoad()
    func fetchInitialLocations()
    func fetchAdditionalLocations()
    func getDetail(index: Int)
    func makeSearch()
    func cancelButtonClicked()
    
}

final class LocationViewModel {
    weak var view: LocationVCProtocol?
    private var service: Service
    var locations: [Location] = []
    var apiInfo: Info? = nil
    var isLoadingMore = false
    var shouldShowSearchBar: Bool = false
    
    init(service: Service) {
        self.service = service
    }
}

extension LocationViewModel: LocationViewModelProtocol {
    func cancelButtonClicked() {
        shouldShowSearchBar = false
        view?.hideSearchBar()
    }
    
    func makeSearch() {
         shouldShowSearchBar = true
         view?.showSearchBar()
    }
    
    func searchLocation(searchText: String) {
        let url = "\(ApiConstants.shared.getUrl(endpoint: .location))/?name=\(searchText)"
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
        let url = ApiConstants.shared.getUrl(endpoint: .location)
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
        view?.hideSearchBar()
        fetchInitialLocations()
    }
}
