//
//  APIClient.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
        
    func fetch<T: Codable>(
        with: URLRequest,
        jsonDecoder: JSONDecoder,
        decode: @escaping (Codable) -> T?,
        completion: @escaping (Result<T, APIError>) -> Void
    )
}
