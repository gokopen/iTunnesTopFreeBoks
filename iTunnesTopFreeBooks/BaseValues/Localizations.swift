//
//  Localizations.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 4.01.2021.
//

import Foundation

// Note: This way choosen because if we want to change the localization during lifecycle of the app, this way will allow the updates of the texts.

class Localizations {
    
    struct Home {
        static var title: String { get { "Home.title".localize() }}
        static var sort: String { get { "Home.sort".localize() }}
        static var sortAll: String { get { "Home.sortAll".localize() }}
        static var sortToNew: String { get { "Home.sortToNew".localize() }}
        static var sortToOld: String { get { "Home.sortToOld".localize() }}
        static var sortOnlyFavorites: String { get { "Home.sortOnlyFavorites".localize() }}
        static var welcome: String { get { "Home.welcome".localize() }}
        static var welcomeInfo: String { get { "Home.welcomeInfo".localize() }}
        static var ok: String { get { "Home.ok".localize() }}
    }
    
    struct Search {
        static var title: String { get { "Search.title".localize() }}
        
        static var warning: String { get { "Search.warning".localize() }}
        static var unableToContinueWithoutSelectFilter: String { get { "Search.tunableToContinueWithoutSelectFilter".localize() }}
        static var ok: String { get { "Search.ok".localize() }}
    }
    
    struct Favorites {
        static var title: String { get { "Favorites.title".localize() }}
    }
    
    struct Detail {
        static var title: String { get { "Detail.title".localize() }}
        static var author: String { get { "Detail.author".localize() }}
        static var releaseDate: String { get { "Detail.releaseDate".localize() }}
    }
}
