//
//  UserModel.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import Foundation

class UserModel: Codable {
    var login: String?
    var avatarUrl: String?
    var followersUrl: String?
    var name: String?
    var email: String?
}
