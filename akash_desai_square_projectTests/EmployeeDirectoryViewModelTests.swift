//
//  akash_desai_squareProjectTests.swift
//  akash_desai_squareProjectTests
//
//  Created by Akash Desai on 2023-01-04.
//

import XCTest
@testable import akash_desai_square_project

class EmployeeDirectoryViewModelTests: XCTestCase {

    var viewModel: EmployeeDirectoryViewModel!
    
    override func setUp() {
        
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_Json_Decoding_Success() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Employees", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) else {
            fatalError("no data")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let failedToDecode: Bool = true

        do {
            let employeeDirectory = try decoder.decode(EmployeeDirectory.self, from: data)
            let firstEmployeeUUID: String = "0d8fcc12-4d0c-425c-8355-390b312b909c"
            XCTAssertEqual(employeeDirectory.employees.first?.uuid, firstEmployeeUUID)
        } catch {
            XCTAssert(failedToDecode)
        }
    
    }
    
    func test_Json_Decoding_Malformed_Data() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Employees_malformed", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) else {
            fatalError("no data")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var failedToDecode: Bool = true

        do {
            let _ = try decoder.decode(EmployeeDirectory.self, from: data)
            failedToDecode = false
            XCTAssert(!failedToDecode)
        } catch {
            XCTAssert(failedToDecode)
        }
    }
    
    func test_Json_Decoding_Empty_Data() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Empty_response", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) else {
            fatalError("no data")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var failedToDecode: Bool = true
        
        do {
            let employeeDirectory = try decoder.decode(EmployeeDirectory.self, from: data)
            failedToDecode = false
            XCTAssert(!failedToDecode)
            XCTAssert(employeeDirectory.employees.isEmpty)
        } catch {
            XCTAssert(failedToDecode)
        }
    }

    func test_employeeDirectoryViewModel() {
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "Employees", ofType: "json")
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path!)) else {
            fatalError("no data")
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let employeeDirectory = try! decoder.decode(EmployeeDirectory.self, from: data)
        let firstEmployeeUUID: String = "0d8fcc12-4d0c-425c-8355-390b312b909c"
        
        viewModel = EmployeeDirectoryViewModel(delegate: self)
        viewModel.employees = employeeDirectory.employees
        
        XCTAssertEqual(employeeDirectory.employees.count, viewModel.numberOfEmployees)
        XCTAssertEqual(employeeDirectory.employees.first?.uuid, firstEmployeeUUID)
    }

}

extension EmployeeDirectoryViewModelTests: EmployeeDirectoryViewModelDelegate {
    func onFetchSuccess() { }
    func onFetchFailed(error: String) { }
}
