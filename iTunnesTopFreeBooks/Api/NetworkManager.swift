//
//  NetworkManager.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 4.01.2021.
//

import Foundation

class NetworkManager {
    
    func downloadFile(url: URL, completion: @escaping (Bool, URL?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: url)
        let task = session.downloadTask(with: request) { (tempUrl, response, error) in
            if error == nil, tempUrl != nil {
                completion(true, tempUrl)
            } else {
                print("Problem occured during dowload of url: \(url) error: \(error?.localizedDescription ?? "nil")")
                completion(false, nil)
            }
        }
        task.resume()
    }
    
    func get<T: Codable>(url: URL, responseType: T.Type, completion: @escaping (Bool, T?) -> Void) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) {data,urlResponse,error in
            if error == nil, let data = data {
                let decoder = JSONDecoder()
                if let result = try? decoder.decode(T.self, from: data) {
                    completion(true,result)
                } else {
                    print("Unable to decode the data - url: \(url)")
                    completion(false,nil)
                }
                
            } else {
                print("Problem occured during dataTask url: \(url) error: \(error?.localizedDescription ?? "nil")")
                completion(false,nil)
            }
        }
        task.resume()
    }
}
