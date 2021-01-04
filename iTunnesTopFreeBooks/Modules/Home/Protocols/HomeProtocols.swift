//
//  HomeProtocols.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

// MARK: - ViewController
protocol HomePresenterToViewControllerProtocol: PresenterToViewControllerProtocol {
    func addItems(uiItems: [BooksUIModel], pageIndex: Int)
    func reloadData()
    func failedToFetchData()
}

protocol HomeViewControllerToPresenterProtocol: ViewControllerToPresenterProtocol {
    func viewLoaded()
    func itemTapped(tappedItemModel: BooksUIModel)
    func fetchNext(awaitingPageIndex: Int)
}

// MARK: - Interactor
protocol HomePresenterToInteractorProtocol: PresenterToInteractorProtocol {
    func fetchData(awaitingPageIndex: Int) 
}

protocol HomeInteractorToPresenterProtocol: InteractorToPresenterProtocol {
    func addFetchedData(data: BooksDataModel, pageIndex: Int)
    func failedToFetchData()
}

// MARK: - Router
protocol HomePresenterToRouterProtocol: RouterProtocol {
    func pushToDetail(from: UIViewController, uiModel: BooksUIModel)
}


