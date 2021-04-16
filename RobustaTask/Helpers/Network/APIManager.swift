//
//  APIManager.swift
//  RobustaTask
//
//  Created by Ashraf Essam on 16/04/2021.
//

import UIKit

class APIManager: NSObject {
    
    static let shared = APIManager()
    
    func fetchReposJSON(completion: @escaping (Result<[ReposModel], Error>) -> ()){
        
        let urlString = Constants.githubReposUrl
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            do {
                let repos = try JSONDecoder().decode([ReposModel].self, from: data!)
                completion(.success(repos))
            }
            catch let jsonError {
                completion(.failure(jsonError))
            }
        }.resume()
    }
}

