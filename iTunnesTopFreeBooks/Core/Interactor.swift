//
//  Interactor.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 2.01.2021.
//

import Foundation

class Interactor: PresenterToInteractorProtocol  {

    private var presenterBase: InteractorToPresenterProtocol?
    
    func getPresenter<T: InteractorToPresenterProtocol> (type: T.Type) -> T {
        return self.presenterBase as! T
    }
    
    func setPresenter<T: InteractorToPresenterProtocol> (_ newPresenter: T) {
        self.presenterBase = newPresenter
    }

}
