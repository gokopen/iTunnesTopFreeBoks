//
//  BooksSearchUIModel.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 4.01.2021.
//

import Foundation

class BooksSearchUIModel: BooksUIModel {
    let genres: [String]
    
    init (id: String, title: String, imageUrl: String, releaseDate: Date, artistName: String, genres: [String]) {
        self.genres = genres
        super.init(id: id, title: title, imageUrl: imageUrl, releaseDate: releaseDate, artistName: artistName)
    }
}
