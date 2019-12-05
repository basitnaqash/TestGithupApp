//
//  FollowerDetailTableViewCell.swift
//  TestGithubApp
//
//  Created by Abdul on 05/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import UIKit

class FollowerDetailTableViewCell: UITableViewCell {
   
    //MARK: - IBOutlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        //Make Avatar Image rounded
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.width / 2
    }
    
    //Clean images
    override func prepareForReuse() {
        avatarImageView.image = nil
    }
    
    //MARK: - Configure Cell
    func configure(model: FollowerModel) {
        downloadImage(url: model.avatarUrl ?? "")
        usernameLabel.text = model.login
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
