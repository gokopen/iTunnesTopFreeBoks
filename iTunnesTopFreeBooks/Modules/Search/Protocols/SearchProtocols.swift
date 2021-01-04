//
//  SearchProtocols.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

// MARK: - ViewController
protocol SearchPresenterToViewControllerProtocol: PresenterToViewControllerProtocol {
    func setItems(uiItems: [BooksSearchUIModel]) 
}

protocol SearchViewControllerToPresenterProtocol: ViewControllerToPresenterProtocol {
    func viewLoaded()
    func itemTapped(tappedItemModel: BooksSearchUIModel)
}

// MARK: - Interactor
protocol SearchPresenterToInteractorProtocol: PresenterToInteractorProtocol {
    func fetchData() 
}

protocol SearchInteractorToPresenterProtocol: InteractorToPresenterProtocol {
    func setFetchedData(data: BooksDataModel)
}

// MARK: - Router
protocol SearchPresenterToRouter: RouterProtocol {
    func pushToDetail(from: UIViewController, uiModel: BooksUIModel)
}
