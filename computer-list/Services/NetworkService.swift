//
//  NetworkService.swift
//  computer-list
//
//  Created by Савелий Вепрев on 02.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//

import Foundation

struct Route<Model> {
    let endpoint: String
}

struct Routes {
    static let list = Route<List>(endpoint: "rest/computers")
    static let detail = Route<Detail>(endpoint: "rest/computers")
    static let same = Route<[Same]>(endpoint: "rest/computers")
}
enum Result<Model> {
    case success(Model)
    case failure(Error)
}

protocol NetworkServiceProtocol {
    func fetch<Model: Codable> (fromParameters param: String, fromRoute route: Route<Model>, completion: @escaping (Result<Model>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    func fetch<Model: Codable> (fromParameters param: String, fromRoute route: Route<Model>, completion: @escaping (Result<Model>) -> Void) {
        
        let baseUrl = "http://testwork.nsd.naumen.ru/"
        
        guard let url = URL(string: "\(baseUrl+route.endpoint)\(param)")
           else {
           completion(.failure(NSError(domain: baseUrl, code: 500)))
           return
       }
        let defaultSession = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
//        dataTask?.cancel()
        
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            dataTask = defaultSession.dataTask(with: request) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                }
                do {
                    let decoder = JSONDecoder()
                    if let data = data {
                      if let jsonString = String(data: data, encoding: .utf8) {
                         print(jsonString)
                      }
                    }
                    if let data = data, let model = try? decoder.decode(Model.self, from: data) {
                        completion(.success(model))
                    }
                    else {
                        completion(.failure(NSError(  domain: baseUrl,
                                                code: 1000,
                                                userInfo: ["error":"wrong model"]))
                        )
                    }
                } catch {
                    completion(.failure(error))
                }
            }
            dataTask?.resume()
        
    }
    
}
