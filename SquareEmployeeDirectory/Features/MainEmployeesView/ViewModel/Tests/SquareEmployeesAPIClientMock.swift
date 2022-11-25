//
//  ProfilePictureRepositoryMock.swift
//  SquareEmployeeDirectoryTests
//
//  Created by David Mar on 11/25/22.
//

import Foundation
@testable import SquareEmployeeDirectory

class SquareEmployeesAPIClientMock: SquareEmployeesAPIClientProtocol {
    var shouldBeEmpty = false
    func getEmployees(completion: @escaping (Result<SquareEmployeesResponse, Error>) -> ()) {
        var response = SquareEmployeesResponse()
        if !shouldBeEmpty {
            response = SquareEmployeesResponse.mockResponse()
        }
        completion(.success(response))
    }
}
