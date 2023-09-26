//
//  ApiManager.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation

final class ApiManager {
    static let shared = ApiManager()
    
    private init() {}
    
    func execute(url: URL, completion: @escaping (Result<Data,Error>) -> ()) {
        let request = URLRequest(url: url)
        let dateTask = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data else {
                completion(.failure(URLError(.badURL)))
                return
            }
            completion(.success(data))
        }
        dateTask.resume()
    }
}
