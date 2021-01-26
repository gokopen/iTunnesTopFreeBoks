//
//  DetailRouter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class DetailRouter: Router, DetailPresenterToRouterProtocol {
    
    static func createModule(uiModel: BooksUIModel) -> DetailViewController {
        let vc = RouterInitializer.createModule(viewType: DetailViewController.self, interactor: DetailInteractor(), presenter: DetailPresenter(), router: DetailRouter())
        vc.uiModel = uiModel
        return vc
    }
    
}
