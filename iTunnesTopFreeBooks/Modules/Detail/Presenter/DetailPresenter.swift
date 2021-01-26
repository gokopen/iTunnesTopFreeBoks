//
//  DetailPresenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 3.01.2021.
//

import Foundation

class DetailPresenter: Presenter   {
    var viewController: DetailPresenterToViewControllerProtocol { get { return getViewController(type: DetailViewController.self)} }
    var interactor: DetailPresenterToInteractorProtocol { get { return getInteractor(type: DetailInteractor.self)} }
    var router: DetailPresenterToRouterProtocol { get { return getRouter(type: DetailRouter.self)} }
}

extension DetailPresenter: DetailViewControllerToPresenterProtocol  {

}

extension DetailPresenter: DetailInteractorToPresenterProtocol  {
    
}
