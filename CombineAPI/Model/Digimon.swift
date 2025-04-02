//
//  Digimon.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.
//

import Foundation

struct Digimon: Decodable{
    var name: String
    var level: String
    var img: String
}

extension Digimon: Identifiable{
    var id: String{
        return name + level
    }
}
