//
//  EmployeesViewController.swift
//  SquareEmployeeDirectory
//
//  Created by David Mar on 11/23/22.
//

import Foundation
import UIKit

class EmployessViewController: UIViewController {
    
    private let tableView = UITableView()
    
    private var viewModel = {
        return EmployeesViewModel(api: SquareEmployeesAPIClient(),
                                  profilePictureRepository: ProfilePictureRepository(profilePictureDiskCache: ProfilePictureDiskCache())
        )
    }()
    
    override func loadView() {
        super.loadView()
        setupTableView()
    }
  
    func setupTableView() {
        view.addSubview(tableView)
        let safeArea = view.layoutMarginsGuide
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(EmployeeTableViewCell.self,
                           forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel.getEmployees()
        viewModel.reloadTableView = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}

extension EmployessViewController: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return viewModel.employeeViewModels.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseIdentifier, for: indexPath) as? EmployeeTableViewCell else {
          Logger.shared.logError(errorString: "Can't reuse \(EmployeeTableViewCell.reuseIdentifier)")
          return UITableViewCell()
      }
      guard let employeeViewModel = viewModel[indexPath.row] else {
          Logger.shared.logError(errorString: "Can't find view model at index row: \(indexPath.row)")
          return UITableViewCell()
      }
      cell.setupCell(viewModel: employeeViewModel)
      return cell
  }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
