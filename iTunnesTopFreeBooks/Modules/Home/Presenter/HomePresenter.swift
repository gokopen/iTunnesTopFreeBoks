//
//  HomePresenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit

class HomePresenter: Presenter  {
    
    var viewController: HomePresenterToViewControllerProtocol! { get { return (self.viewControllerBase as! HomePresenterToViewControllerProtocol)} }
    var interactor: HomePresenterToInteractorProtocol! { get { return (self.interactorBase as! HomePresenterToInteractorProtocol)} }
    var router: HomePresenterToRouterProtocol! { get { return getRouter(type: HomeRouter.self)} }
}

extension HomePresenter: HomeViewControllerToPresenterProtocol  {
    
    func viewLoaded() {
        self.interactor.fetchData(awaitingPageIndex: 0)
        NotificationCenter.default.addObserver(self,selector: #selector(self.favoriteUpdated), name: NSNotification.Name(rawValue: Constants.NotificationCenter.favoriteUpdated), object: nil)
    }
    
    @objc func favoriteUpdated(notification: NSNotification) {
        self.viewController.reloadData()
    }
    
    func itemTapped(tappedItemModel: BooksUIModel, fromVC: UIViewController) {
        self.router.pushToDetail(from: fromVC, uiModel: tappedItemModel)
    }
    
    
    func fetchNext(awaitingPageIndex: Int) {
        self.interactor.fetchData(awaitingPageIndex: awaitingPageIndex)
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
            self.viewController.addItems(uiItems: uiItems, pageIndex: pageIndex)
        }
    }
    
    func failedToFetchData() {
        self.viewController.failedToFetchData()
    }
}
