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
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.text = "Square Employees"
        return titleLabel
    }()
    
    private var viewModel = {
        return EmployeesViewModel(api: SquareEmployeesAPIClient(),
                                  profilePictureRepository: ProfilePictureRepository(profilePictureDiskCache: ProfilePictureDiskCache())
        )
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(tableView)
        view.addSubview(titleLabel)
        setupTitleLabel()
        setupTableView()
    }
  
    func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.register(EmployeeTableViewCell.self,
                           forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 32).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
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
