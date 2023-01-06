//
//  APlError.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case invalidData
    case emptyData
    case decoding
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .invalidData: return "Invalid Data"
        case .emptyData: return "Empty Response"
        case .decoding: return "An error occurred while decoding data"
        }
    }
}
