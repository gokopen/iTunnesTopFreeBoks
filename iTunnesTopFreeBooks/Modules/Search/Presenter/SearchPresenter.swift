//
//  SearchPresenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class SearchPresenter: Presenter<SearchViewController, SearchInteractor, SearchRouter>, SearchViewControllerToPresenterProtocol, SearchInteractorToPresenterProtocol  {
    
    func viewLoaded() {
        self.interactor?.fetchData()
    }
    
    func setFetchedData(data: BooksDataModel) {
        var uiItems = [BooksSearchUIModel]()
        
        if let results = data.feed?.results {
            for item in results {
                var genres = [String]()
                if let grs = item.genres {
                    for g in grs {
                        genres.append(g.name ?? "")
                    }
                }
                
                let uiModel = BooksSearchUIModel(id: item.id ?? "", title: item.name ?? "", imageUrl: item.artworkUrl100 ?? "", releaseDate: Utils.stringToDate(string: item.releaseDate) ?? Date(), artistName: item.artistName ?? "", genres: genres)
                uiItems.append(uiModel)
            }
        }
        
        self.viewController?.setItems(uiItems: uiItems)
    }
    
    func itemTapped(tappedItemModel: BooksSearchUIModel) {
        if let vc = self.viewController {
            self.router?.pushToDetail(from: vc, uiModel: tappedItemModel)
        }
    }

}
