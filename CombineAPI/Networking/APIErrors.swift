//
//  APIErrors.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.
//

import Foundation

enum APIErrors: Error{
    case invalidURLError
    case parsingError
    case noDataError
    case responseError(Int)
}
