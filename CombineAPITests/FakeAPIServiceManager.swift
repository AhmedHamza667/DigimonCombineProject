//
//  FakeAPIServiceManager.swift
//  CombineAPITests
//
//  Created by Ahmed Hamza on 3/4/25.
//

import Foundation
@testable import CombineAPI
import Combine

class FakeAPIServiceManager: APIServicing{
    var testPath = ""
    func fetchData<T>(from url: String, modelType: T.Type) -> AnyPublisher<T, any Error> where T : Decodable {
        let bundel = Bundle(for: FakeAPIServiceManager.self)
        let urlObj = bundel.url(forResource: testPath, withExtension: "json")
        guard let urlObj = urlObj else{
            return Fail(error: APIErrors.invalidURLError)
                .eraseToAnyPublisher()
        }
        do {
            let data = try Data(contentsOf: urlObj)
            let parsedData = try JSONDecoder().decode(modelType.self, from: data)
            return Just(parsedData)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()

        }
    }
    
}
