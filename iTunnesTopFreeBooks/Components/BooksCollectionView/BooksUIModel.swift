//
//  BooksUIModel.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class BooksUIModel: Equatable {
    let id: String
    let title: String
    let imageUrl: String
    let releaseDate: Date
    let artistName: String
    
    init(id: String, title: String, imageUrl: String, releaseDate: Date, artistName: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.releaseDate = releaseDate
        self.artistName = artistName
    }
    
    static func == (lhs: BooksUIModel, rhs: BooksUIModel) -> Bool {
        return lhs.id == rhs.id && lhs.imageUrl == rhs.imageUrl && lhs.title == rhs.title && lhs.releaseDate == rhs.releaseDate && lhs.artistName == rhs.artistName
    }
}
