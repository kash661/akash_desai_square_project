//
//  EmployeeDirectory.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

struct EmployeeDirectory: Codable, Equatable {
    let employees: [Employee]
}

#if DEBUG
extension EmployeeDirectory {
    static func mock(employees: [Employee] = [.mock()]) -> EmployeeDirectory {
        EmployeeDirectory(employees: employees)
    }
}
#endif
