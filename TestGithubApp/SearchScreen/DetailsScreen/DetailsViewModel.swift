//
//  DetailsViewModel.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import Foundation

//Protocol for callback when data is loaded
protocol DetailsViewModelDelegate: ViewModelDelegate {}

class DetailsViewModel {
    
    //MARK: - Variables and Constants
    var userModel: UserModel?
    var followersDataModel: [FollowerModel]?
    var delegate: DetailsViewModelDelegate?
    
    //MARK: - Load Data
    init(with userModel: UserModel?, delegate: DetailsViewModelDelegate) {
        self.userModel = userModel
        self.delegate = delegate
        
        getFollowersData(url: userModel?.followersUrl ?? "")
    }
    
    //MARK: - Get Followers Data
    func getFollowersData(url: String){
        APIManager.shared.getFollowersData(url: url) {[weak self] (followersData) in
           DispatchQueue.main.async {
               if let followersData = followersData {
                   self?.followersDataModel = followersData
                   self?.delegate?.onDataLoaded()
               }
               else {
                   self?.delegate?.onDataLoadError()
               }
           }
        }
    }
}
