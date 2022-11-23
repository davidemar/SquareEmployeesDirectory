//
//  SquareEmployeesAPIClient.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/22/22.
//

import Foundation

enum SquareEmployeesAPI: API {
    case getEmployees
    case getEmployeesMalformed
    case getEmployeesEmpty
    
    var scheme: HTTPScheme {
        switch self {
        case .getEmployees, .getEmployeesMalformed, .getEmployeesEmpty:
            return .https
        }
    }
    var baseURL: String {
        switch self {
        case .getEmployees, .getEmployeesMalformed, .getEmployeesEmpty:
            return "s3.amazonaws.com"
        }
    }
    var path: String {
        switch self {
        case .getEmployees:
            return "/sq-mobile-interview/employees.json"
        case .getEmployeesMalformed:
            return "/sq-mobile-interview/employees_malformed.json"
        case .getEmployeesEmpty:
            return "/sq-mobile-interview/employees_empty.json"
        }
    }
    var method: HTTPMethod {
        switch self {
        case .getEmployees, .getEmployeesMalformed, .getEmployeesEmpty:
            return .get
        }
    }
    var parameters: [URLQueryItem]? {
        return nil
    }
}

class SquareEmployeesAPIClient: SquareEmployeesAPIClientProtocol {
    class func getEmployees() {
        let endpoint = SquareEmployeesAPI.getEmployees
        APIClient.request(endpoint: endpoint) {
            (result: Result<SquareEmployeesResponse, Error>) in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                Logger.logError(error: error)
            }
        }
    }
}
