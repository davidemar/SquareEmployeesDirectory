//
//  EmployeeViewModel.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import Foundation

struct EmployeeViewModel {
    var id: String
    var name: String
    var phoneNumber: String?
    var email: String
    var biography: String?
    var photoUrlSmall: String?
    var photoUrlLarge: String?
    var team: String
    var employeeType: EmployeeType
    
    init(employee: Employee) {
        self.id = employee.id
        self.name = employee.name
        self.phoneNumber = employee.phoneNumber
        self.email = employee.email
        self.biography = employee.biography
        self.photoUrlSmall = employee.photoUrlSmall
        self.photoUrlLarge = employee.photoUrlLarge
        self.team = employee.team
        self.employeeType = employee.employeeType
    }
    
}
