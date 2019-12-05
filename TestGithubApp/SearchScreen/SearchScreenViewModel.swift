//
//  SearchScreenViewModel.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import Foundation

//Protocol for callback when data is loaded
protocol SearchScreenViewModelDelegate: ViewModelDelegate {}

class SearchScreenViewModel {
    
    //MARK: - Variables and Constants
    var dataModel: UserModel?
    var delegate: SearchScreenViewModelDelegate?
    
    //MARK: - Initialize...
    init(delegate: SearchScreenViewModelDelegate) {
        self.delegate = delegate
    }
    
    //MARK: - Get User Data...
    func getUserData(user: String) {
        APIManager.shared.getUserData(user: user) {[weak self] (userData) in
            DispatchQueue.main.async {
                if let userData = userData {
                    self?.dataModel = userData
                    self?.delegate?.onDataLoaded()
                }
                else {
                    self?.delegate?.onDataLoadError()
                }
            }
         }
     }
}
