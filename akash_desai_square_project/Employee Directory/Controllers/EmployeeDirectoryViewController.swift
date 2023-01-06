//
//  EmployeeDirectoryViewController.swift
//  akash_desai_sqaureProject
//
//  Created by Akash Desai on 2023-01-01.
//

import UIKit

class EmployeeDirectoryViewController: UIViewController {
    private static let cellIdentifier = "employeeCell"
    
    private let tableBackgroundView = UIView()
    private var viewModel: EmployeeDirectoryViewModel!

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeDirectoryViewController.cellIdentifier)
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        return control
    }()
    
    lazy var emptyStateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 32)
        label.text = "No employees"
        return label
    }()
    
    lazy var refreshEmployeesButton: UIButton = {
        let button = UIButton()
        button.setTitle("Refresh", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(refreshButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableBackgroundView.frame = tableView.bounds
    }
}

// MARK: SetupView
private extension EmployeeDirectoryViewController {
    func setUpView() {
        view.backgroundColor = .white
        
        view.addSubview(tableView)
        tableBackgroundView.backgroundColor = .clear
        tableView.backgroundView = tableBackgroundView
        
        tableView.addSubview(refreshControl)
        tableBackgroundView.addSubview(emptyStateLabel)
        tableBackgroundView.addSubview(refreshEmployeesButton)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            emptyStateLabel.centerXAnchor.constraint(equalTo: tableBackgroundView.centerXAnchor),
            emptyStateLabel.centerYAnchor.constraint(equalTo: tableBackgroundView.centerYAnchor),
            refreshEmployeesButton.topAnchor.constraint(equalTo: emptyStateLabel.bottomAnchor, constant: 24),
            refreshEmployeesButton.centerXAnchor.constraint(equalTo: tableBackgroundView.centerXAnchor)
        ])
        
    }
    
    func setupViewModel() {
        viewModel = EmployeeDirectoryViewModel(delegate: self)
        viewModel.fetchEmployees()
    }
    
    @objc func refreshButtonTapped() {
        // added pulsating animation on label, for user interaction
        UIView.animate(withDuration: 0.4, animations: {
            self.emptyStateLabel.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { _ in
            UIView.animate(withDuration: 0.4) {
                self.emptyStateLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
        viewModel.refreshTableView()
    }
    
    @objc func refreshTableView() {
        viewModel.refreshTableView()
    }
}

// MARK: UITableViewDelegate & UITableViewDataSource
extension EmployeeDirectoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfEmployees
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeDirectoryViewController.cellIdentifier, for: indexPath) as! EmployeeCell
        
        cell.presentation = viewModel.presentation(at: indexPath)
        return cell
    }
}


// MARK: EmployeeDirectoryViewModelDelegate
extension EmployeeDirectoryViewController: EmployeeDirectoryViewModelDelegate {
    func onFetchSuccess() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func onFetchFailed(error: String) {
        refreshControl.endRefreshing()
        // handle errors
    }
}
