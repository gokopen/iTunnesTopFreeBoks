//
//  FavoritesRouter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class FavoritesRouter: Router, FavoritesPresenterToRouterProtocol {
    
    class func createModule(viewController: FavoritesViewController) {
        let interactor = FavoritesInteractor()
        let presenter = FavoritesPresenter()
        let router = FavoritesRouter()
        RouterInitializer.createModule(view: viewController, interactor: interactor, presenter: presenter, router: router)
    }
    
    func pushToDetail(from: UIViewController, uiModel: BooksUIModel) {
        let vc = DetailRouter.createModule(uiModel: uiModel)
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
