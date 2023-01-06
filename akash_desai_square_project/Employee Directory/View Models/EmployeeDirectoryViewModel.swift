//
//  EmployeeDirectoryViewModel.swift
//  akash_desai_sqaureProject
//
//  Created by Akash Desai on 2023-01-01.
//

import Foundation

class EmployeeDirectoryViewModel {
    
    private weak var delegate: EmployeeDirectoryViewModelDelegate?
    private var isFetchInProgress = false

    var employees: [Employee] = []
    
    public var numberOfEmployees: Int {
        return employees.count
    }
    
    // MARK: Init
    init(delegate: EmployeeDirectoryViewModelDelegate) {
        self.delegate = delegate
    }
    
    func fetchEmployees() {
        // to avoid multiple api calls
        guard !isFetchInProgress else {
            return
        }
        
        isFetchInProgress = true
        
        EmployeeService.shared.getEmployees(url: randomUrl(), decoding: EmployeeDirectory.self) { [unowned self] result in
            switch result {
            case .success(let employeeDirectory):
                isFetchInProgress = false
                let sortedEmployees = employeeDirectory.employees.sorted { $0.team < $1.team }
                self.employees = sortedEmployees
                self.delegate?.onFetchSuccess()
            case .failure(let error):
                isFetchInProgress = false
                self.delegate?.onFetchFailed(error: error.localizedDescription)
            }
        }
    }
    
    func presentation(at indexPath: IndexPath) -> Employee? {
        guard indexPath.row < employees.count else { return nil }
        return employees[indexPath.row]
    }
    
    func refreshTableView() {
        fetchEmployees()
    }
}

private extension EmployeeDirectoryViewModel {
    
    func randomUrl() -> URL? {
        let urls = [
            "https://s3.amazonaws.com/sq-mobile-interview/employees.json",
            "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json",
            "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
        ]
        let randomIndex = Int.random(in: 0..<urls.count)
        return URL(string: urls[randomIndex])
    }
    
}
