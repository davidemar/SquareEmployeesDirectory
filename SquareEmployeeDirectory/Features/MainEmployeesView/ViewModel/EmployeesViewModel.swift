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
    var showEmptyBanner: (() -> Void)?
    
    private var employees = [Employee]()
    private var repository: ProfilePictureRepositoryProtocol?
    
    var employeeViewModels = [EmployeeViewModel]() {
        didSet {
            if employeeViewModels.count == 0{
                showEmptyBanner?()
            } else {
                reloadTableView?()
            }
        }
    }
    
    init(api: SquareEmployeesAPIClientProtocol, profilePictureRepository: ProfilePictureRepositoryProtocol?) {
        self.apiClient = api
        self.repository = profilePictureRepository
    }
    
    func getEmployees() {
        apiClient.getEmployees {[weak self] result in
            guard let self = self else { return }
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
            vms.append(EmployeeViewModel(employee: employee, profilePictureRepository: repository))
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
