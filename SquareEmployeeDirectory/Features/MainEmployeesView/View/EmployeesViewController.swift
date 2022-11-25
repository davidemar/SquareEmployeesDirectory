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
    private let refreshControl: UIRefreshControl = {
        return UIRefreshControl()
    }()
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
        tableView.refreshControl = refreshControl
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControlPulled), for: .valueChanged)
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
        setupViewModelListeners()
        getEmployees()
        Logger.shared.logEvent(name: "Employees Viewed", surface: "Employees View Controller")
    }
    
    private func setupViewModelListeners() {
        viewModel.reloadTableView = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.backgroundView = nil
                self.hideRefreshControl()
                self.tableView.reloadData()
            }
        }
        viewModel.showEmptyBanner = {
            DispatchQueue.main.async {
                self.hideRefreshControl()
                self.displayEmptyMessage()
            }
        }
    }
    
    private func hideRefreshControl() {
        self.refreshControl.isHidden = true
        self.tableView.refreshControl?.endRefreshing()
    }
    
    private func getEmployees() {
        viewModel.getEmployees()
    }
    
}

//MARK: UITableViewDataSource, UITableViewDelegate
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

//MARK: - Pull to refresh
extension EmployessViewController {
    @objc func refreshControlPulled() {
        getEmployees()
    }
}

//MARK: Empty State
extension EmployessViewController {
    func displayEmptyMessage() {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = "There are no employees, try pull to refresh"
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 16, weight: .light)
        messageLabel.sizeToFit()
        tableView.backgroundView = messageLabel;
        tableView.separatorStyle = .none;
    }
}
