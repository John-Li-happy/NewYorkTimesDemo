//
//  ServiceManager.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/30/20.
//

import Foundation

class ServiceManager {
    
    static let `shared` = ServiceManager()
    private init() {}
    
    func fetchData(url: String, parameters: [String: String], completionHandler: @escaping (Data?, Error?) -> Void) {
        guard var components = URLComponents(string: url) else { return }
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let completeURL = components.url else { return }
        
        let task = URLSession.shared.dataTask(with: completeURL) { data, response, error in
            guard error == nil else { completionHandler(nil, error); return }
            let success = true
            guard let httpResponse = response as? HTTPURLResponse else { return }
            if success == (200 ..< 399).contains(httpResponse.statusCode) {
                completionHandler(data, nil)
            } else {
                let failResponse = NSError(domain: "Failed to get the response! Please check your authorization", code: httpResponse.statusCode, userInfo: nil)
                completionHandler(nil, failResponse)
            }
        }
        
        task.resume()
    }
    
}
