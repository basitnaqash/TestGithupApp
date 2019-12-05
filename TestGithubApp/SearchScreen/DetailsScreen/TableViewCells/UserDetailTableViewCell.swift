//
//  UserDetailTableViewCell.swift
//  TestGithubApp
//
//  Created by Abdul on 05/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import UIKit

class UserDetailTableViewCell: UITableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        //Make Avatar Image rounded
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
    //Clean images
    override func prepareForReuse() {
        avatarImageView.image = nil
    }
    
    //MARK: - Configure Cell
    func configure(model: UserModel) {
        downloadImage(url: model.avatarUrl ?? "N/A")
        nameLabel.text = "Name: " + (model.name ?? "N/A")
        usernameLabel.text = "Username: " + (model.login ?? "N/A")
        emailLabel.text = "Email: " + (model.email ?? "N/A")
    }
    
    //MARK: - Download Image
    func downloadImage(url: String) {
        if let url =  URL(string: url) {
            APIManager.shared.getImage(from:url) {[weak self] (image, error) in
                DispatchQueue.main.async() {
                    self?.avatarImageView.image = image
                }
            }
        }
    }
}
