//
//  ServiceManager.swift
//  NewYorkTimesDemo
//
//  Created by Zhaoyang Li on 10/30/20.
//

import Foundation

enum AppError: Error {
    case invalidUrl
    case invalidData
    case decodingFailed
    case custom(String)

    static var genericError: String {
        "Something went wrong, please refresh or try again"
    }
}

class ServiceManager {
    
    static let `shared` = ServiceManager()
    private init() {}
    
    func fetchData<T: Decodable>(url: String, parameters: [String: String], type: T.Type, completionHandler: @escaping (T?, AppError?) -> Void) {
        
        let completionOnMain: (T?, AppError?) -> Void = { result, error in
            DispatchQueue.main.async {
                completionHandler(result, error)
            }
        }
        self.fetchDataFromServer(url: url, parameters: parameters, type: type, completionHandler: completionOnMain)
    }
    
    private func fetchDataFromServer<T: Decodable>(url: String, parameters: [String: String], type: T.Type, completionHandler: @escaping (T?, AppError?) -> Void) {
        
        guard var components = URLComponents(string: url) else {
            completionHandler(nil, AppError.invalidUrl)
            return
        }
        components.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        guard let completeURL = components.url else {
            completionHandler(nil, AppError.invalidUrl)
            return
        }
        
        let task = URLSession.shared.dataTask(with: completeURL) { data, response, error in
            
            guard error == nil else { return completionHandler(nil, AppError.custom(error?.localizedDescription ?? AppError.genericError)) }
            
            guard let response = response as? HTTPURLResponse else { return completionHandler(nil, AppError.custom(AppError.genericError)) }
            
            switch response.statusCode {
            case 200...299:
                guard let unwrappedData = data else {
                    return completionHandler(nil, AppError.invalidData)
                }
                do {
                    let model = try JSONDecoder().decode(T.self, from: unwrappedData)
                    completionHandler(model, nil)
                } catch {
                    print(error)
                    completionHandler(nil, AppError.decodingFailed)
                }
                
            default:
                completionHandler(nil, AppError.custom(AppError.genericError))
            }
        }
        task.resume()
    }
}
