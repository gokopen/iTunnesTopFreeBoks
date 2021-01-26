//
//  BooksDataModel.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

// NOTE: I need to modify the model to able to develop pagination with current api. If I were not need it, I would not set them as var, I would set them as let

class BooksDataModel: Codable, Equatable {
    var feed: BooksFeedDataModel?
    
    static func == (lhs: BooksDataModel, rhs: BooksDataModel) -> Bool {
        return lhs.feed == rhs.feed
    }
}

class BooksFeedDataModel: Codable, Equatable {
    var results: [BooksFeedResultsDataModel]?
    
    static func == (lhs: BooksFeedDataModel, rhs: BooksFeedDataModel) -> Bool {
        return lhs.results == rhs.results
    }
}

class BooksFeedResultsDataModel: Codable, Equatable {
    var id: String?
    var name: String?
    var artworkUrl100: String?
    var releaseDate: String?
    var artistName: String?
    var genres: [BooksFeedResultsGenresDataModel]?
    
    static func == (lhs: BooksFeedResultsDataModel, rhs: BooksFeedResultsDataModel) -> Bool {
        return lhs.id == rhs.id && lhs.artworkUrl100 == rhs.artworkUrl100 && lhs.name == rhs.name && lhs.releaseDate == rhs.releaseDate && lhs.artistName == rhs.artistName && lhs.genres == rhs.genres
    }
}

class BooksFeedResultsGenresDataModel: Codable, Equatable {
    var genreId: String?
    var name: String?
    var url: String?
    
    static func == (lhs: BooksFeedResultsGenresDataModel, rhs: BooksFeedResultsGenresDataModel) -> Bool {
        return lhs.genreId == rhs.genreId && lhs.name == rhs.name && lhs.url == rhs.url
    }
}
