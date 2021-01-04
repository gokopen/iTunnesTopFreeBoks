//
//  Presenter.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import UIKit

class Presenter<V: PresenterToViewControllerProtocol, I: PresenterToInteractorProtocol, R: RouterProtocol> : ViewControllerToPresenterProtocol, InteractorToPresenterProtocol {
    var viewController: V?
    var interactor: I?
    var router: R?
}
