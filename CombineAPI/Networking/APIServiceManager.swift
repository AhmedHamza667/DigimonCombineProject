//
//  APIServiceManager.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.
//

import Foundation
import Combine

protocol APIServicing{
    func fetchData<T: Decodable>(from url:String, modelType: T.Type) -> AnyPublisher<T, Error>
}

struct APIServiceManager{
    let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
}

extension APIServiceManager: APIServicing{
    func fetchData<T>(from url: String, modelType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        guard let urlObj = URL(string: url) else{
            return Fail(error: APIErrors.invalidURLError).eraseToAnyPublisher()
        }
        return urlSession.dataTaskPublisher(for: urlObj)
            .tryMap({ data, response in
                guard let httpResponse = response as? HTTPURLResponse else{
                    throw APIErrors.noDataError
                }
                guard (200...299).contains(httpResponse.statusCode) else{
                    throw APIErrors.responseError(httpResponse.statusCode)
                }
                return data
            })
            .decode(type: modelType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
}
