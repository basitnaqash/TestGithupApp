//
//  DetailsViewController.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Variables and Constants
    var viewModel: DetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = DETAILS
        
        registerCells()
        
        tableView.dataSource = self
        
        tableView.isHidden = true
        
    }
    
    //MARK: - Load data
    func load(with userModel: UserModel?) {
        viewModel = DetailsViewModel.init(with: userModel, delegate: self)
    }
    
    //MARK: - Show Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: ALERT, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: OK, style: UIAlertAction.Style.default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
               
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Register Cells
    func registerCells() {
        tableView.register(UINib(nibName: USER_DETAIL_CELL, bundle: nil), forCellReuseIdentifier: USER_DETAIL_CELL)
        tableView.register(UINib(nibName: FOLLOWER_DETAIL_CELL, bundle: nil), forCellReuseIdentifier: FOLLOWER_DETAIL_CELL)
        
    }
}

//MARK: - Details ViewModel Delegate
extension DetailsViewController : DetailsViewModelDelegate {
    func onDataLoaded() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
        tableView.isHidden = false
    }

    func onDataLoadError() {
        activityIndicator.stopAnimating()
        showAlert(message: ERROR_MSG)
    }
}

//MARK: - TableView DataSource
extension DetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            return viewModel?.followersDataModel?.count ?? 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: USER_DETAIL_CELL) as! UserDetailTableViewCell
            cell.configure(model: viewModel?.userModel ?? UserModel())
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: FOLLOWER_DETAIL_CELL) as! FollowerDetailTableViewCell
            cell.configure(model: viewModel?.followersDataModel?[indexPath.row] ?? FollowerModel())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return USER_SECTION_HEADER
        }
        else {
            return FOLLOWERS_SECTION_HEADER
        }
    }
}
