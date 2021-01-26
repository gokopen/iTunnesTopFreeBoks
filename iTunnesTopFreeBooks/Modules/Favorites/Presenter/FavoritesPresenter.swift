//
//  FavoritesPresenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class FavoritesPresenter: Presenter  {
    var viewController: FavoritesPresenterToViewControllerProtocol! { get { return getViewController(type: FavoritesViewController.self)} }
    var interactor: FavoritesPresenterToInteractorProtocol! { get { return getInteractor(type: FavoritesInteractor.self)} }
    var router: FavoritesPresenterToRouterProtocol! { get { return getRouter(type: FavoritesRouter.self)} }
}

extension FavoritesPresenter: FavoritesViewControllerToPresenterProtocol {
    func viewLoaded() {
        self.interactor.fetchData()
        NotificationCenter.default.addObserver(self,selector: #selector(self.favoriteUpdated), name: NSNotification.Name(rawValue: Constants.NotificationCenter.favoriteUpdated), object: nil)
    }
    
    @objc func favoriteUpdated(notification: NSNotification) {
        self.interactor.fetchData()
    }
    
    func itemTapped(tappedItemModel: BooksUIModel, fromVC: UIViewController) {
        self.router.pushToDetail(from: fromVC, uiModel: tappedItemModel)
    }
}


extension FavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    func setFetchedData(data: BooksDataModel) {
        if let results = data.feed?.results  {
            var uiItems = [BooksUIModel]()
            for item in results {
                if let id = item.id, FavoritesManager.getFavoirted(id: id) {
                    let uiModel = BooksUIModel(id: id, title: item.name ?? "", imageUrl: item.artworkUrl100 ?? "", releaseDate: Utils.stringToDate(string: item.releaseDate) ?? Date(), artistName: item.artistName ?? "")
                    uiItems.append(uiModel)
                }
            }
            self.viewController.setItems(uiItems: uiItems)
        }
        
    }
}
