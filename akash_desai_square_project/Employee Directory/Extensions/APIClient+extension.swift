//
//  EmployeeService.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import Foundation

extension APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    func decodingTask<T: Decodable>(with request: URLRequest, decodingType: T.Type, jsonDecoder: JSONDecoder, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.hasSuccessStatusCode {
                if let data = data {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let genericModel = try decoder.decode(decodingType, from: data)
                        completion(genericModel, nil)
                    } catch {
                        completion(nil, .decoding)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .requestFailed)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with: URLRequest, jsonDecoder: JSONDecoder, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: with, decodingType: T.self, jsonDecoder: jsonDecoder) { data, error in
            
            DispatchQueue.main.async {
                guard let json = data else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.success(value))
                } else {
                    completion(.failure(.decoding))
                }
            }
        }
        task.resume()
    }
}
