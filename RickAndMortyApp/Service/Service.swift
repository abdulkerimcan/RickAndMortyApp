//
//  Service.swift
//  RickAndMortyApp
//
//  Created by Abdulkerim Can on 25.09.2023.
//

import Foundation
import Alamofire

final class Service {
    
    func fetch<T: Codable>(url: String,expecting type: T.Type ,completion: @escaping (Result<T,Error>) -> ()) {
        
        AF.request(url,method: .get).validate().responseDecodable(of: T.self) { response in
            
            if let error = response.error {
                completion(.failure(error))
                return
            }
            
            guard let item = response.value else {
                completion(.failure(AFError.explicitlyCancelled))
                return
            }
            
            completion(.success(item))
        }
    }
}
