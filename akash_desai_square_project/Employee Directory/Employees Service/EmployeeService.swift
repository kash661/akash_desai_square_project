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
    
    typealias JSONTaskCompletionHandler<T: Codable> = (Result<T, APIError>) -> Void
    
    func getEmployees<T: Codable>(url: URL?, decoding: T.Type, completion: @escaping JSONTaskCompletionHandler<T>) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let jsonEncoder = JSONEncoder()
        
        fetch(with: request, jsonDecoder: jsonDecoder, decode: { json -> T? in
            guard let employeeDirectory = json as? T else { return nil }
            do {
                let data = try jsonEncoder.encode(employeeDirectory)
                if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                    in: .userDomainMask).first {
                    let filePath = documentDirectory.appendingPathComponent("EmployeeDirectory.json")
                    do {
                        try data.write(to: filePath)
                    } catch {
                    }
                }
            } catch {
                
            }
            return employeeDirectory
        }, completion: completion)
    }
}
