//
//  APIManager.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    typealias JSONTaskCompletionHandler = (Decodable?, Error?) -> Void
    
    //MARK: - Variables and Constants
    static let shared = APIManager()
    //For storing images in cache
    let imageCache = NSCache<NSString, UIImage>()

    
    //MARK: - Get User data...
    func getUserData(user: String, onComplete: @escaping (UserModel?)->Void) {
        JSONFetcher.shared.fetchJSONData(url: USER_DATA_URL.appending(user), method: .GET) {(data, error) in
               DispatchQueue.global(qos: .userInitiated).async {
                  if let json = data {
                      do {
                          let jsonDecoder = JSONDecoder()
                          jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                          let decoded = try jsonDecoder.decode(UserModel.self, from: json)
                          onComplete(decoded)
                      } catch {
                          print("\(#function) error: \(error)")
                      }
                  }
                  else {
                      onComplete(nil)
                  }
              }
          }
      }
    
    //MARK: - Get Followers data...
    func getFollowersData(url: String, onComplete: @escaping ([FollowerModel]?)->Void) {
        JSONFetcher.shared.fetchJSONData(url: url, method: .GET) {(data, error) in
            DispatchQueue.global(qos: .userInitiated).async {
                if let json = data {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decoded = try jsonDecoder.decode([FollowerModel].self, from: json)
                        onComplete(decoded)
                    } catch {
                        print("\(#function) error: \(error)")
                    }
                }
                else {
                    onComplete(nil)
                }
            }
        }
    }
    
    //MARK: - Get Image from URL
    func getImage(from url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, nil)
        }
        else {
            URLSession.shared.dataTask(with: url) {[weak self] (data, response, error) in
             if let error = error {
                completion(nil, error)
            }
             else if let data = data, let image = UIImage(data: data) {
                self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image, nil)
            }
            else {
                completion(nil, error)
            }
            }.resume()
        }
    }
}
