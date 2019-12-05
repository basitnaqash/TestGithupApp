//
//  APIServices.swift
//  TestGithubApp
//
//  Created by Abdul on 04/12/19.
//  Copyright © 2019 Abdul Basit. All rights reserved.
//

import Foundation

public enum URLMethod: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PUT = "PUT"
    case PATCH = "PATCH"
}

//Class for fetching the JSON data from the API...
class JSONFetcher{

    static let shared = JSONFetcher()
    
    //Function for fetching the JSON data from the API...
    func fetchJSONData(url: String, method: URLMethod?, timeOut: TimeInterval = 1, onComplete: @escaping (Data?, Error?) -> Void) {

        guard let url = URL(string: url) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method?.rawValue
        
        urlRequest.timeoutInterval = timeOut
       
        URLSession.shared.dataTask(with: urlRequest) {(data, response, error) in
        if let error = error {
            onComplete(nil, error)
        }
            
        guard let data = data else
        {
            onComplete(nil, error)
            return
        }
        onComplete(data, nil)
        
        }.resume()
        
    }
}
