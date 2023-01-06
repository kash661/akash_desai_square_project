//
//  Employee.swift
//  akash_desai_squareProject
//
//  Created by Akash Desai on 2023-01-06.
//

struct Employee: Codable, Equatable {
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let photoUrlSmall: String
    let photoUrlLarge: String
    let team: String
    let employeeType: String
    
}

#if DEBUG
extension Employee {
    static func mock(uuid: String = "123" ,
                     fullName: String = "John Smith",
                     phoneNumber: String = "123 456 4555",
                     emailAddress: String = "johnSmith@sqaure.com",
                     biography: String = "Engineering Manager",
                     photoUrlSmall: String = "www.images.com/small/john",
                     photoUrlLarge: String = "www.images.com/large/john",
                     team: String = "Mobile Consumer",
                     employeeType: String = "Full Time"
    ) -> Employee {
        Employee(uuid: uuid,
                 fullName: fullName,
                 phoneNumber: phoneNumber,
                 emailAddress: emailAddress,
                 biography: biography,
                 photoUrlSmall: photoUrlSmall,
                 photoUrlLarge: photoUrlSmall,
                 team: team,
                 employeeType: employeeType
        )
    }
}
#endif
