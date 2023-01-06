//
//  ViewModelProtocols.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

import Foundation

protocol EmployeeDirectoryViewModelDelegate: AnyObject {
    func onFetchSuccess()
    func onFetchFailed(error: String)
}
