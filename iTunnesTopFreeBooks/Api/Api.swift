//
//  Api.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import Foundation

class Api {
    
    private let networkManager = NetworkManager()
    
    func download(url: URL, completion: @escaping (Bool, URL?) -> Void) {
        networkManager.downloadFile(url: url, completion: completion)
    }
    
    func getTopFreeBooks(completion: @escaping (Bool, BooksDataModel?) -> Void) {
        if let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/books/top-free/all/100/non-explicit.json") {
            networkManager.get(url: url, responseType: BooksDataModel.self, completion: completion)
        }
    }
    
    func getTopFreeBooksWithPaging(index: Int, completion: @escaping (Bool, Int, BooksDataModel?) -> Void) {
        self.getTopFreeBooks { (success, response) in
            if success, let response = response, let results = response.feed?.results {
                response.feed?.results = results
                let newResponse = BooksDataModel()
                newResponse.feed = BooksFeedDataModel()
                newResponse.feed?.results = []
                let start = index * 20
                var end = start + 19
                if end >= results.count {
                    end = results.count
                }
                
                let res = start >= results.count ? [] : results[start...end]
                newResponse.feed?.results?.append(contentsOf: res)
                completion(success, index, newResponse)
            } else {
                completion(false, index, nil)
            }
        }
    }
    
}
