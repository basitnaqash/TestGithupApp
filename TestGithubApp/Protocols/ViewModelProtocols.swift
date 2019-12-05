//
//  ViewModelProtocols.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import Foundation

protocol ViewModelDelegate : class {
    func onDataLoaded()
    func onDataLoadError()
}
