//
//  ServiceProtocol.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    
    func get<E, D>(path: String, params: E, responseType: D.Type, callback: @escaping (D?, Error?) -> Void) where E: Encodable, D : Decodable
    
}
