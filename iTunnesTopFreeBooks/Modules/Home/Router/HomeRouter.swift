//
//  MainRouter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import UIKit

class HomeRouter: Router, HomePresenterToRouterProtocol {
    
    class func createModule(viewController: HomeViewController) {
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        RouterInitializer.createModule(view: viewController, interactor: interactor, presenter: presenter, router: router)
    }
    
    func pushToDetail(from: UIViewController, uiModel: BooksUIModel) {
        let vc = DetailRouter.createModule(uiModel: uiModel)
        from.navigationController?.pushViewController(vc, animated: true)
    }
}
