//
//  HomePresenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit

class HomePresenter: Presenter<HomeViewController, HomeInteractor, HomeRouter>  {
    
}

extension HomePresenter: HomeViewControllerToPresenterProtocol  {
    
    func viewLoaded() {
        self.interactor?.fetchData(awaitingPageIndex: 0)
        NotificationCenter.default.addObserver(self,selector: #selector(self.favoriteUpdated), name: NSNotification.Name(rawValue: Constants.NotificationCenter.favoriteUpdated), object: nil)
    }
    
    @objc func favoriteUpdated(notification: NSNotification) {
        self.viewController?.reloadData()
    }
    
    func itemTapped(tappedItemModel: BooksUIModel) {
        if let vc = self.viewController {
            self.router?.pushToDetail(from: vc, uiModel: tappedItemModel)
        }
    }
    
    
    func fetchNext(awaitingPageIndex: Int) {
        self.interactor?.fetchData(awaitingPageIndex: awaitingPageIndex)
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol  {
    
    func addFetchedData(data: BooksDataModel, pageIndex: Int) {
        if let dataResults = data.feed?.results {
            var uiItems = [BooksUIModel]()
            for item in dataResults {
                let uiModel = BooksUIModel(id: item.id ?? "", title: item.name ?? "", imageUrl: item.artworkUrl100 ?? "", releaseDate: Utils.stringToDate(string: item.releaseDate) ?? Date(), artistName: item.artistName ?? "")
                uiItems.append(uiModel)
            }
            self.viewController?.addItems(uiItems: uiItems, pageIndex: pageIndex)
        }
    }
    
    func failedToFetchData() {
        self.viewController?.failedToFetchData()
    }
}
