//
//  EmployeeServiceTests.swift
//  akash_desai_squareProjectTests
//
//  Created by Akash Desai on 2023-01-06.
//

import XCTest
@testable import akash_desai_square_project

class EmployeeServiceTests: XCTestCase {
    
    var testURLSession: URLSession!

    override func setUp() {
        super.setUp()
        testURLSession = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        testURLSession = nil
        super.tearDown()
    }

    func test_valid_URL_Sucess() {
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")
        let successStatusCode: Int = 200
        let expectation = expectation(description: "Completion block hit")
        
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = testURLSession.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            expectation.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, successStatusCode)
        
    }
    
    func test_valid_URL_Failure() {
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.js")
        let failureStatusCode: Int = 403
        let expectation = expectation(description: "Completion block hit")
        
        var statusCode: Int?
        
        let dataTask = testURLSession.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            expectation.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(statusCode, failureStatusCode)
        
    }
}
