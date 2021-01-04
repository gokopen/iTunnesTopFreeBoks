//
//  DetailRouter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class DetailRouter: Router {
    static func createModule(uiModel: BooksUIModel) -> DetailViewController {
        let vc = DetailRouter.createModule(viewController: DetailViewController.self, interactor: DetailInteractor(), presenter: DetailPresenter(), router: DetailRouter())
        vc.uiModel = uiModel
        return vc
    }
}
