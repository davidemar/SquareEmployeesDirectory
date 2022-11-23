//
//  Employee.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/22/22.
//

// MARK: - Employee
struct Employee: Codable {
    enum EmployeeType: String, Codable {
        case contractor = "CONTRACTOR"
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
    }
    var uuid: String
    var fullName: String
    var phoneNumber: String?
    var emailAddress: String
    var biography: String?
    var photoUrlSmall: String?
    var photoUrlLarge: String?
    var team: String
    var employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography = "biography"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
    
}

struct SquareEmployeesResponse: Codable {
    var employees = [Employee]()
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let throwables = try values.decode([Throwable<Employee>].self, forKey: .employees)
        throwables.forEach {
                    switch $0.result {
                    case .success(let employee):
                        employees.append(employee)
                    case .failure(let error):
                        Logger.logError(error: error)
                    }
        }
    }
}
