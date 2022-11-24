//
//  SquareEmployeesAPIClientProtocol.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/22/22.
//

import Foundation

protocol SquareEmployeesAPIClientProtocol {
    func getEmployees(completion: @escaping (Result<SquareEmployeesResponse, Error>) -> ())
}
