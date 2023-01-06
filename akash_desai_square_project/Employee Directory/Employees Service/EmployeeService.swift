//
//  EmployeeService.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import Foundation

class EmployeeService: APIClient {
    
    var session: URLSession = URLSession(configuration: .default)
    
    private init() { }
    
    static let shared: EmployeeService = EmployeeService()
    
    typealias JSONTaskCompletionHandler<T: Decodable> = (Result<T, APIError>) -> Void
    
    func getEmployees<T: Decodable>(url: URL?, decoding: T.Type, completion: @escaping JSONTaskCompletionHandler<T>) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        fetch(with: request, jsonDecoder: jsonDecoder, decode: { json -> T? in
            guard let employees = json as? T else { return nil }
            return employees
        }, completion: completion)
    }
}
