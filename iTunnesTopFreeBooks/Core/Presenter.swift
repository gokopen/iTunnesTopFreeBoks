//
//  Presenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit

class Presenter : ViewControllerToPresenterProtocol, InteractorToPresenterProtocol {
    var viewControllerBase: PresenterToViewControllerProtocol?
    var interactorBase: PresenterToInteractorProtocol?
    var routerBase: RouterProtocol?
    
    func setup<V: PresenterToViewControllerProtocol, I: PresenterToInteractorProtocol, R: RouterProtocol>(viewController: V, interactor: I, router: R) {
        self.viewControllerBase = viewController
        self.interactorBase = interactor
        self.routerBase = router
    }
    
    func getViewController<T: PresenterToViewControllerProtocol> (type: T.Type) -> T {
        return self.viewControllerBase as! T
    }
    
    func getInteractor<T: PresenterToInteractorProtocol> (type: T.Type) -> T {
        return self.interactorBase as! T
    }
    
    func getRouter<T: RouterProtocol> (type: T.Type) -> T {
        return self.routerBase as! T
    }
    
}

