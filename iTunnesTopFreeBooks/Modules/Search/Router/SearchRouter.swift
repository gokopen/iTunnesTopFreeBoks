//
//  SearchRouter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class SearchRouter: Router, SearchPresenterToRouterProtocol {
    class func createModule(viewController: SearchViewController) {
        let interactor = SearchInteractor() 
        let presenter = SearchPresenter()
        let router = SearchRouter()
        RouterInitializer.createModule(view: viewController, interactor: interactor, presenter: presenter, router: router)
    }
    
    func pushToDetail(from: UIViewController, uiModel: BooksUIModel) {
        let vc = DetailRouter.createModule(uiModel: uiModel)
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
