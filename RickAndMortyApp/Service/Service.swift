//
//  Service.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation

final class Service {
    
    func fetch<T: Codable>(endpoint: Endpoints,expecting type: T.Type ,completion: @escaping (Result<T,Error>) -> ()) {
        guard let url = URL(string: ApiURL.getUrl(endpoint: endpoint)) else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ApiManager.shared.execute(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
