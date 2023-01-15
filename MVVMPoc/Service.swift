//
//  Service.swift
//  MVVMPoc
//
//  Created by Thiago Almeida Leite on 14/01/23.
//

import Foundation

enum ServiceError: Error {
    case noData
}

class Service {
    static let shared = Service()
    
    private init(){}
    
    func getRandomJoke(by handle: @escaping (Result<ChuckModel, Error>) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    handle(.failure(error ?? ServiceError.noData))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(ChuckModel.self, from: data)
                    handle(.success(model))
                } catch {
                    handle(.failure(error))
                }
            }
            
        }.resume()
    }
}

struct ChuckModel: Codable {
    let id: String
    let value: String
}
