//
//  Employee.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/22/22.
//

enum EmployeeType: String, Codable {
    case contractor = "CONTRACTOR"
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
}

struct Employee: Codable {
    
    var id: String
    var name: String
    var phoneNumber: String?
    var email: String
    var biography: String?
    var photoUrlSmall: String?
    var photoUrlLarge: String?
    var team: String
    var employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "full_name"
        case phoneNumber = "phone_number"
        case email = "email_address"
        case biography = "biography"
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
    
}

struct SquareEmployeesResponse: Codable {
    
    var employees = [Employee]()
    
    init() {}
    
    static func mockResponse() -> SquareEmployeesResponse {
        var response = SquareEmployeesResponse()
        let employee = Employee(id: "7777", name: "David", email: "david@david.com", team: "iOS", employeeType: .fullTime)
        response.employees.append(employee)
        return response
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let throwables = try values.decode([Throwable<Employee>].self, forKey: .employees)
        throwables.forEach {
                    switch $0.result {
                    case .success(let employee):
                        employees.append(employee)
                    case .failure(let error):
                        Logger.shared.logError(error: error)
                    }
        }
    }
}
