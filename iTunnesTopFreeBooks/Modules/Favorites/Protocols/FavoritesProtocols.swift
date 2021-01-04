//
//  FavoritesProtocols.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

// MARK: - ViewController
protocol FavoritesPresenterToViewControllerProtocol: PresenterToViewControllerProtocol {
    func setItems(uiItems: [BooksUIModel]) 
}

protocol FavoritesViewControllerToPresenterProtocol: ViewControllerToPresenterProtocol {
    func viewLoaded()
    func itemTapped(tappedItemModel: BooksUIModel)
}

// MARK: - Interactor
protocol FavoritesPresenterToInteractorProtocol: PresenterToInteractorProtocol {
    func fetchData() 
}

protocol FavoritesInteractorToPresenterProtocol: InteractorToPresenterProtocol {
    func setFetchedData(data: BooksDataModel)
}

// MARK: - Router
protocol FavoritesPresenterToRouter: RouterProtocol {
    func pushToDetail(from: UIViewController, uiModel: BooksUIModel)
}
