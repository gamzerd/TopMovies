//
//  Service.swift
//  TopMovies
//
//  Created by Gamze on 1/25/19.
//  Copyright © 2019 gamzerd. All rights reserved.
//

import Foundation

class Service: ServiceProtocol {
    
    var url: String
    var defaultParams: [String:String]?
    
    init(url: String, defaultParams: [String:String]) {
        self.url = url
        self.defaultParams = defaultParams
    }
    /**
     * Makes a GET http request to the given path and passes the result to the callback.
     * field values based on the corresponding rate value in the list.
     */
    func get<E, D>(path: String, params: E, responseType: D.Type, callback: @escaping (D?, Error?) -> Void) where E: Encodable, D : Decodable {
        
        // build URL
        let endpoint = self.url + path
        let urlComponents = NSURLComponents(string: endpoint)!
        urlComponents.queryItems = []
        
        // encode the params and decode it to [String:String] to build the query parameters
        var paramMap: [String:String] = [:]
        do {
            let encodedData = try JSONEncoder().encode(params)
            paramMap = try JSONDecoder().decode([String:String].self, from: encodedData)
        } catch {
            // return error
            callback(nil, error)
            return
        }
        
        // add all default parameters to the query
        if let params = self.defaultParams {
            params.keys.forEach { key in
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: params[key]))
            }
        }
        
        // add all query parameters given in the request
        paramMap.keys.forEach { key in
            urlComponents.queryItems?.append(URLQueryItem(name: key, value: paramMap[key]))
        }
        
        let request = URLRequest(url: urlComponents.url!)
        
        let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            do {
             //   print(String(data: Data(data), encoding: .utf8) as Any)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                let decodedResponse = try decoder.decode(responseType, from: data)
                
                // return result to the callback
                callback(decodedResponse, nil)
            } catch {
                // return error
                callback(nil, error)
            }
        }
        
        task.resume()
    }
}
