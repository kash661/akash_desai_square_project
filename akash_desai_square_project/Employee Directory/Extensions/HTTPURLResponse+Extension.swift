//
//  HTTPURLResponse+Extension.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import Foundation

extension HTTPURLResponse {
    var hasSuccessStatusCode: Bool {
        return 200...299 ~= statusCode
    }
}
