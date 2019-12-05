//
//  ViewController.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    //MARK: - Variables and Constants
    var viewModel: SearchScreenViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SearchScreenViewModel(delegate: self)
    }
    
    //MARK: - View will Appear
    override func viewWillAppear(_ animated: Bool) {
        //Clean searchbar
        searchBar.text = ""
    }
    
    //MARK: - IBAction
    @IBAction func searchButtonTapped(_ sender: Any) {
        if isValid(input: searchBar.text ?? "") {
            viewModel?.getUserData(user: searchBar.text ?? "")
            activityIndicator.startAnimating()
        }
        else {
            showAlert(message: INVALID_INPUT)
        }
    }
    
    //MARK: - Validate user input
    func isValid(input: String) -> Bool {
        if input.isEmpty { //FIXME: - Include more validations in future
            return false
        }
        else {return true}
    }
    
    //MARK: - Show Alert
    func showAlert(message: String) {
        let alert = UIAlertController(title: ALERT, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: OK, style: UIAlertAction.Style.default, handler: { action in alert.dismiss(animated: true, completion: nil)}))
            
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Navigate to Details Screen
    func navigateToDetailScreen() {
        let storyboard = UIStoryboard(name: MAIN_STORYBOARD, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: DETAILS_VIEW_CONTROLLER) as! DetailsViewController
        vc.load(with: viewModel?.dataModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - Search Screen ViewModel Delegate
extension ViewController : SearchScreenViewModelDelegate {
    func onDataLoaded() {
        activityIndicator.stopAnimating()
        if viewModel?.dataModel?.login == nil {
            //User not found
            showAlert(message: USER_NOT_FOUND)
        }
        else {
            navigateToDetailScreen()
        }
    }

    func onDataLoadError() {
        activityIndicator.stopAnimating()
        showAlert(message: ERROR_MSG)
    }
}
