//
//  EmployeesViewModel.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import Foundation

class EmployeesViewModel: NSObject {

    var apiClient: SquareEmployeesAPIClientProtocol
    var reloadTableView: (() -> Void)?
    
    private var employees = [Employee]()
    
    var employeeViewModels = [EmployeeViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(api: SquareEmployeesAPIClientProtocol) {
        self.apiClient = api
    }
    
    func getEmployees() {
        apiClient.getEmployees { result in
            switch result {
            case .success(let response):
                self.handleEmployeesResponse(response: response)
            case .failure(let error):
                Logger.shared.logError(error: error)
            }
        }
    }
    
    private func handleEmployeesResponse(response: SquareEmployeesResponse) {
        self.employees = response.employees
        var vms = [EmployeeViewModel]()
        for employee in employees {
            vms.append(EmployeeViewModel(employee: employee))
        }
        employeeViewModels = vms
    }
    
}

extension EmployeesViewModel {
    subscript(index: Int) -> EmployeeViewModel? {
        guard index < employeeViewModels.count else { return nil }
        return employeeViewModels[index]
    }
    var count: Int {
        return employeeViewModels.count
    }
}
