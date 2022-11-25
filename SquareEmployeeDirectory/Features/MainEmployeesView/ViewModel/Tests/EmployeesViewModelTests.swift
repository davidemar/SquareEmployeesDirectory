//
//  EmployeesViewModelTests.swift
//  SquareEmployeeDirectoryTests
//
//  Created by David Mar on 11/25/22.
//

import XCTest
@testable import SquareEmployeeDirectory

class EmployeesViewModelTests: XCTestCase {
    
    func test_fetch_success() {
        let squareEmployeesAPIClientMock = SquareEmployeesAPIClientMock()
        squareEmployeesAPIClientMock.shouldBeEmpty = false
        let viewModel = EmployeesViewModel(api: squareEmployeesAPIClientMock,
                                           profilePictureRepository: nil)
        let expectation = self.expectation(description: "Fetching success")
        var reloadTableView = false
        viewModel.reloadTableView = {
            reloadTableView = true
            expectation.fulfill()
        }
        viewModel.getEmployees()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(reloadTableView)
    }
    
    func test_show_empty_banner() {
        let squareEmployeesAPIClientMock = SquareEmployeesAPIClientMock()
        squareEmployeesAPIClientMock.shouldBeEmpty = true
        let viewModel = EmployeesViewModel(api: squareEmployeesAPIClientMock,
                                           profilePictureRepository: nil)
        let expectation = self.expectation(description: "show empty banner")
        var showEmptyBanner = false
        viewModel.showEmptyBanner = {
            showEmptyBanner = true
            expectation.fulfill()
        }
        viewModel.getEmployees()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(showEmptyBanner)
    }
    
}
